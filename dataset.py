import numpy as np
import random
from tqdm import tqdm

import cachedrandom


class TripletsDataset(object):
    """
    Class for handling triplets data (u, i, r).
    """
    def __init__(self, raw_data, threshold_user=20, threshold_item=5, rnd_seed=42):

        self.threshold_user = threshold_user
        self.threshold_item = threshold_item

        self.statistics = {}

        # fix randomness
        self.seed = rnd_seed
        self.set_random_seed(rnd_seed)

        # calculate item counts (and move to blacklist if less than threshold_item)
        i_cnt = {}
        for row in tqdm(raw_data, desc='Calculate items counts', leave=False):
            u, i, r, t = row.astype(int)
            i_cnt[i] = i_cnt.get(i, 0) + 1
        i_blacklist = set([k for k, v in i_cnt.items() if v < threshold_item])
        self.statistics['items'] = set([k for k, v in i_cnt.items() if v >= threshold_item])

        # calculate item counts (and move to blacklist if less than threshold_user)
        u_cnt = {}
        for row in tqdm(raw_data, desc='Calculate users counts', leave=False):
            u, i, r, t = row.astype(int)
            if i not in i_blacklist:
                u_cnt[u] = u_cnt.get(u, 0) + 1
        u_blacklist = set([k for k, v in u_cnt.items() if v < threshold_user])
        self.statistics['users'] = set([k for k, v in u_cnt.items() if v >= threshold_user])


        # assemble self.data like {user:[(item, rating),...], ...}
        self.data = {}
        self.statistics['cnt_total'] = 0
        for row in tqdm(raw_data, desc='Assemble .data', leave=False):
            u, i, r, t = list(map(int, row))
            # filtering blaclisted elements
            if (u in u_blacklist) or (i in i_blacklist):
                continue
            self.data[u] = self.data.get(u, []) + [(i, r)]
            self.statistics['cnt_total'] += 1
        self.data_keys = list(self.data.keys())

        self.init_cached_random()


    def set_random_seed(self, seed):
        # fix randomness
        np.random.seed(seed)
        random.seed(seed)

    def init_cached_random(self):
        # init cached randomizers
        self.pair_sampler = cachedrandom.CachedSampler2from5(blob_size=10000000)
        self.data_keys_sampler = cachedrandom.CachedRandomizer(high=len(self.data_keys), blob_size=10000000)




    def train_test_split(self, n_train, seed=None):
        if seed is None:
            print('Warning: random seed is None, default class seed ({}) will be used'.format(self.seed))
            seed = self.seed
        self.set_random_seed(seed)

        # .train : {user: {rating: [items, ...], ...}}
        self.train = {}
        self.statistics['cnt_train'] = 0

        # .test : {user: [(item, rating), ..]} [sorted by rating]
        self.test = {}
        self.statistics['cnt_test'] = 0

        for u in tqdm(self.data, desc='Split users', leave=False):
            # select random indicies which will be used for training for current user u
            train_inds = set(random.sample(range(len(self.data[u])), n_train))
            for n, (i, r) in enumerate(self.data[u]):
                if n in train_inds:
                    # move to train
                    user_dict = self.train.get(u, {})
                    rating_list = user_dict.get(r, [])
                    rating_list.append(i)
                    user_dict[r] = rating_list
                    self.train[u] = user_dict
                    self.statistics['cnt_train'] += 1
                else:
                    # move to test
                    self.test[u] = self.test.get(u, []) + [(i, r)]
                    self.statistics['cnt_test'] += 1

            # ad-hoc for situation with all equal ratings in train
            if len(self.train[u].keys()) == 1:
                print('No rating diversity in train set for user {}, do swap!'.format(u))
                the_only_rating = list(self.train[u].keys())[0]
                for n, (i, r) in enumerate(self.test[u]):
                    # find first different rating in test and swap it with 0-th in train
                    if r != the_only_rating:
                        self.train[u][r] = [i]
                        extracted_i = self.train[u][the_only_rating][0]
                        self.train[u][the_only_rating] = self.train[u][the_only_rating][1:]
                        del self.test[u][n]
                        self.test[u] = self.test[u] + [(extracted_i, the_only_rating)]
                        break
            self.test[u] = sorted(self.test[u], key=lambda x: x[1], reverse=True)

        # intersect train and test items
        self.used_in_trainset = set()
        for u in self.train:
            for r in self.train[u]:
                self.used_in_trainset.update(self.train[u][r])
        for u in self.test:
            self.test[u] = [(i, r) for (i, r) in self.test[u] if i in self.used_in_trainset]


    def sample_train_triple(self):

        user = self.data_keys[self.data_keys_sampler.sample()]
        stats = self.train[user]
        stats_keys = list(stats.keys())
        assert len(stats_keys) > 1, 'user {} has only 1 rating!'.format(user)

        left_rating, right_rating = self.pair_sampler.sample(stats_keys)
        assert left_rating != right_rating

        left_value = random.choice(stats[left_rating])
        right_value = random.choice(stats[right_rating])
        y = (left_rating > right_rating)*2 - 1
        diff = left_rating - right_rating
        return (user, left_value, right_value, y, diff)


    def sample_train_batch(self,n_samples=256):
        retval = np.zeros((n_samples, 5)).astype(np.int32)
        for i in range(n_samples):
            retval[i] = self.sample_train_triple()
        return {
            'users': retval[:, 0],
            'left_items': retval[:, 1],
            'right_items': retval[:, 2],
            'y': retval[:, 3].astype(np.float32),
            'diff': retval[:, 4].astype(np.float32),
        }
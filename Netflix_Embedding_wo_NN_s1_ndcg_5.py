import random

import numpy as np
import random
import pickle
from tqdm import tqdm
import letor_metrics
import pyximport
pyximport.install()

import matplotlib

# Import Netflix Data
raw_data = np.loadtxt('/data/sidana/nnmf_ranking/netflix/dat.netflix.sample/dat.nf.sample', delimiter=',')

# In[21]:

from dataset import TripletsDataset

# In[22]:

ds = TripletsDataset(raw_data, threshold_user=20, rnd_seed=42)
ds.train_test_split(n_train=10)

ds.init_cached_random()


# # define model

# In[24]:

import tensorflow as tf
import bprmf


import imp


# In[26]:

imp.reload(bprmf)


# In[48]:

# model.destroy()

# In[27]:

N_USERS =  2649422#int(max(raw_data[:, 0])) + 1
N_ITEMS = 17760 #int(max(raw_data[:, 1])) + 1
N_EMBEDDINGS = 1

model = BPR_MF(N_USERS, N_ITEMS, N_EMBEDDINGS, alpha_reg=0.1)
model.build_graph()
model.initialize_session()

losses = []
batch_size = 512
for n_batches, cur_optim in [(1000, model.trainer_2)]:
    for i in tqdm(range(n_batches)):
        batch = ds.sample_train_batch(n_samples=batch_size)
        fd = {
            model.user_ids:  batch['users'], 
            model.left_ids:  batch['left_items'],
            model.right_ids: batch['right_items'],
            model.target_y:  batch['y'],
        }
        el, reg, t, _ = model.session.run(
            [model.embedding_loss, model.regularization, model.target, cur_optim], 
            feed_dict=fd
        )
        losses.append((el, reg, t))
        if i%500==0:
            user_norm = np.linalg.norm(model.weights_u)
            item_norm = np.linalg.norm(model.weights_i)
            print('[it {}] weight norms, users: {}, items: {}'.format(i, user_norm, item_norm))
            
# In[31]:

ndcg_vals = []
for u in tqdm(ds.data_keys, desc='Prediction', leave=True):
    fd = {
            model.user_ids:  (np.ones(N_ITEMS)*u).astype(np.int32), 
            model.left_ids:  np.array([i for (i, r) in ds.test[u]]).astype(np.int32),
        }
    response = model.session.run(model.embedding_left, feed_dict=fd)[:, 0]

    # make relevances
    relevances = np.array([r for (i, r) in ds.test[u]])
    predicted_ranking = np.argsort(-response)
    # calc score
    gain = letor_metrics.ndcg_from_ranking(relevances, predicted_ranking, 5)
    ndcg_vals.append(gain)

# In[32]:

print (np.mean(ndcg_vals))




import random
import numpy as np
import random
import pickle
import letor_metrics
import pyximport
import sys
from tqdm import tqdm
pyximport.install()
import matplotlib


raw_data_train = np.loadtxt('/data/sidana/recnet_draft/cold_start/uics/'+sys.argv[1]+'/recnet_all/train_all_raw.csv', skiprows = 1, delimiter=',')
raw_data_test = np.loadtxt('/data/sidana/recnet_draft/cold_start/uics/'+sys.argv[1]+'/recnet_all/test_all_cart_raw.csv', skiprows = 1, delimiter=',')
raw_data = np.concatenate((raw_data_train, raw_data_test))
from dataset_tt_static_ucs import TripletsDataset

ds = TripletsDataset(raw_data_train, raw_data_test, threshold_user=60, rnd_seed=42)
ds.train_test_split()

ds.init_cached_random()
import tensorflow as tf
import bprnn
import imp

N_USERS = int(max(raw_data[:, 0])) + 1
N_ITEMS = int(max(raw_data[:, 1])) + 1
N_EMBEDDINGS = 1

import tensorflow.contrib.slim as slim
imp.reload(bprnn)

#%%
def inner_network(user_emb, item_emb):
    joined_input = tf.concat(1, [user_emb, item_emb])
    net = slim.fully_connected(inputs=joined_input, num_outputs=32, activation_fn=tf.nn.relu)
#     net = slim.fully_connected(inputs=joined_input, num_outputs=64, activation_fn=tf.nn.relu)
#     net = slim.dro
    net = slim.fully_connected(inputs=net, num_outputs=1, activation_fn=None)
    return net

model = bprnn.BPR_NN(N_USERS, N_ITEMS, N_EMBEDDINGS, alpha=int(sys.argv[2]), beta=int(sys.argv[3]), alpha_reg=0.005, inner_net=inner_network)
model.build_graph()
model.initialize_session()

losses = []
batch_size = 512
for n_batches, cur_optim in [(10000, model.trainer_3)]:
    for i in tqdm(range(n_batches)):
        batch = ds.sample_train_batch(n_samples=batch_size)
        fd = {
            model.user_ids:  batch['users'],
            model.left_ids:  batch['left_items'],
            model.right_ids: batch['right_items'],
            model.target_y:  batch['y'],
        }
        el, nl, reg, t, _ = model.session.run(
            [model.embedding_loss, model.net_loss, model.regularization, model.target, cur_optim],
            feed_dict=fd
        )
        losses.append((el, nl, reg, t))
        if i%500==0:
            user_norm = np.linalg.norm(model.weights_u)
            item_norm = np.linalg.norm(model.weights_i)
            print('[it {}] weight norms, users: {}, items: {}'.format(i, user_norm, item_norm))
            print('[it {}] metrics (emb_loss, net_loss, reg, target): {}'.format(i, losses[-1]))

#%%

export_basename = '/data/sidana/recnet_draft/cold_start/uics/'+sys.argv[1]+'/recnet_all/vectors/'
export_pred = open(export_basename + 'pr_'+sys.argv[1]+'_'+sys.argv[2]+sys.argv[3], 'w')
export_true = open(export_basename + 'gt_'+sys.argv[1]+'_'+sys.argv[2]+sys.argv[3], 'w')

ndcg_vals = []
for u in tqdm(ds.data_keys, desc='Prediction', leave=True):
    if not u in ds.test:
        continue
    response = np.zeros(len(ds.test[u]))
    fd = {
            model.user_ids:  (np.ones(len(ds.test[u]))*u).astype(np.int32), 
            model.left_ids:  np.array([i for (i, r) in ds.test[u]]).astype(np.int32),
        }
    response += model.session.run(model.embedding_left, feed_dict=fd)[:, 0]
    response += model.session.run(model.left_output, feed_dict=fd)[:, 0]

    # make relevances
    relevances = np.array([r for (i, r) in ds.test[u]])
    items = np.array([i for (i, r) in ds.test[u]])  # it's already sorted by true relevance
    itemsGroundTruth = np.array([i for (i,r) in ds.test[u] if r == 1])
    predicted_ranking = np.argsort(-response)

    # write down predictions
    export_pred.write(' '.join(map(str, [u] + list(items[predicted_ranking]))) + '\n')
    export_true.write(' '.join(map(str, [u] + list(itemsGroundTruth))) + '\n')

    # calc score
    gain = letor_metrics.ndcg_from_ranking(relevances, predicted_ranking, 10)
    ndcg_vals.append(gain)


# In[32]:

print(ndcg_vals)


# In[ ]:





# coding: utf-8

# In[1]:


import random

import numpy as np
import random
import pickle
from tqdm import tqdm
import letor_metrics
import pyximport
pyximport.install()


# In[2]:

raw_data = np.loadtxt('/home/ama/sidana/dat.nf.sample', delimiter=',')


# In[3]:

from dataset import TripletsDataset


# In[4]:

ds = TripletsDataset(raw_data, threshold_user=30, threshold_item=5, rnd_seed=42)
ds.train_test_split(n_train=20)
ds.init_cached_random()


# # define model

# In[5]:

import tensorflow as tf
from bprnn_wo_embedding import BPR_NN_WO_EMB


# In[7]:

N_USERS = int(max(raw_data[:, 0])) + 1
N_ITEMS = int(max(raw_data[:, 1])) + 1
N_EMBEDDINGS = None # since we dont need this


# In[8]:

import tensorflow.contrib.slim as slim

def inner_network_wo_embeddings(user_ids, item_ids):
    # squash users and intems with one-hot encoding
    oh_users = tf.one_hot(user_ids, depth=N_USERS)
    oh_items = tf.one_hot(item_ids, depth=N_ITEMS)
    # join them
    joined_input = tf.concat(1, [oh_users, oh_items])
    # and apply feed-forward NN
    net = slim.fully_connected(inputs=joined_input, num_outputs=64, activation_fn=tf.nn.relu)
    net = slim.fully_connected(inputs=net, num_outputs=1, activation_fn=None)
    return net


# In[9]:

model = BPR_NN_WO_EMB(inner_net=inner_network_wo_embeddings)
model.build_graph()
model.initialize_session()


# In[10]:

losses = []
batch_size = 512
for n_batches, cur_optim in [(2000, model.trainer_3)]:
    for i in tqdm(range(n_batches)):
        batch = ds.sample_train_batch(n_samples=batch_size)
        fd = {
            model.user_ids:  batch['users'], 
            model.left_ids:  batch['left_items'],
            model.right_ids: batch['right_items'],
            model.target_y:  batch['y'],
        }
        nl,  t, _ = model.session.run([model.net_loss,  model.target, cur_optim], feed_dict=fd)
        losses.append((nl, t))
        if i%200==0:
            print('[it {}] metrics: {}'.format(i, losses[-1]))


# In[11]:

# plot([x[0] for x in losses], c='m', label='net_loss')
# grid()
# legend()
# xlabel('n_batches')
# ylabel('logloss')


# In[12]:

ndcg_vals = []
for u in tqdm(ds.data_keys, desc='Prediction', leave=True):
    fd = {
            model.user_ids:  (np.ones(len(ds.test[u]))*u).astype(np.int32), 
            model.left_ids:  np.array([i for (i, r) in ds.test[u]]).astype(np.int32),
        }
    response = model.session.run(model.left_output, feed_dict=fd)[:, 0]

    # make relevances
    relevances = np.array([r for (i, r) in ds.test[u]])
    predicted_ranking = np.argsort(-response)
    # calc score
    gain = letor_metrics.ndcg_from_ranking(relevances, predicted_ranking, 10)
    ndcg_vals.append(gain)


# In[13]:

print(np.mean(ndcg_vals))


# In[14]:

model.destroy()


# In[ ]:




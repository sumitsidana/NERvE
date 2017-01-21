
# coding: utf-8

# In[19]:

#get_ipython().magic(u'pylab inline')
import random

import numpy as np
import random
import pickle
from tqdm import tqdm
import letor_metrics
import pyximport
pyximport.install()

import matplotlib
# In[20]:

raw_data = np.loadtxt('/data/sidana/nnmf_ranking/netflix_data/netflix/dat.nf.sample', delimiter=',')


# In[21]:

from dataset import TripletsDataset


# In[22]:

ds = TripletsDataset(raw_data, threshold_user=30, rnd_seed=42)
ds.train_test_split(n_train=20)


# In[5]:

# pickle.dump(ds, open('./tmp/ds.pkl', 'wb'))
# ds = pickle.load(open('./tmp/ds_50_mf.pkl', 'rb'))


# In[23]:

ds.init_cached_random()


# # define model

# In[24]:

import tensorflow as tf
import bprnn


# In[25]:

import imp


# In[26]:

imp.reload(bprnn)


# In[48]:

# model.destroy()


# In[27]:

N_USERS =  17771#int(max(raw_data[:, 0])) + 1
N_ITEMS = 2649430 #int(max(raw_data[:, 1])) + 1
N_EMBEDDINGS = 1


# In[28]:

import tensorflow.contrib.slim as slim

def inner_network(user_emb, item_emb):
    joined_input = tf.concat(1, [user_emb, item_emb])
    net = slim.fully_connected(inputs=joined_input, num_outputs=64, activation_fn=tf.nn.relu)
#     net = slim.fully_connected(inputs=joined_input, num_outputs=64, activation_fn=tf.nn.relu)
#     net = slim.dro
    net = slim.fully_connected(inputs=net, num_outputs=1, activation_fn=None)
    return net


# In[29]:

model = bprnn.BPR_NN(N_USERS, N_ITEMS, N_EMBEDDINGS, alpha=0.3, beta=0.7, alpha_reg=0.0, inner_net=inner_network)
model.build_graph()
model.initialize_session()


# In[30]:

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


# In[53]:

# plot([x[0] for x in losses], c='b', label='embedding_loss', alpha=0.5)
# plot([x[1] for x in losses], c='m', label='net_loss', alpha=0.5)
# plot([x[2]*model.alpha_reg for x in losses], c='r', label='reg*alpha', alpha=0.5)
# plot([x[3] for x in losses], c='g', label='target', alpha=0.5)
# grid()
# legend()
# xlabel('n_batches')
# ylabel('logloss')


# In[31]:

ndcg_vals = []
for u in tqdm(ds.data_keys, desc='Prediction', leave=True):
    response = np.zeros(len(ds.test[u]))
    fd = {
            model.user_ids:  (np.ones(len(ds.test[u]))*u).astype(np.int32), 
            model.left_ids:  np.array([i for (i, r) in ds.test[u]]).astype(np.int32),
        }
    response += model.session.run(model.embedding_left, feed_dict=fd)[:, 0]
    response += model.session.run(model.left_output, feed_dict=fd)[:, 0]

    # make relevances
    relevances = np.array([r for (i, r) in ds.test[u]])
    predicted_ranking = np.argsort(-response)
    # calc score
    gain = letor_metrics.ndcg_from_ranking(relevances, predicted_ranking, 10)
    ndcg_vals.append(gain)


# In[32]:

print (np.mean(ndcg_vals))
print (np.std(ndcg_vals))


# In[ ]:




from lightfm import LightFM
import data
import sys
import numpy as np


train, test = data.get_movielens_positive_data('/data/sidana/recnet_draft/cold_start/ucs/'+sys.argv[1]+'/lightfm_all')
uid_train, pid_train, nid_train = data.get_triplets(train)
uid_test, pid_test, nid_test = data.get_triplets(test)

model = LightFM(no_components=4,loss='logistic',learning_rate=0.01, item_alpha=0.05, user_alpha=0.05)
model.fit(train, epochs=10, num_threads=1)

train_all, test_all = data.get_movielens_data('/data/sidana/recnet_draft/cold_start/ucs/'+sys.argv[1]+'/lightfm_all')
uid_all_train, pid_all_train, nid_all_train = data.get_triplets(train_all)
uid_all_test, pid_all_test, nid_all_test = data.get_triplets(test_all)

export_basename = '/data/sidana/recnet_draft/cold_start/ucs/'+sys.argv[1]+'/lightfm_all'+'/vectors/'
export_pred = open(export_basename + 'pr', 'w')
#export_pred = open(export_basename + 'pr', 'w')
export_true = open(export_basename + 'gt', 'w')
#export_true = open(export_basename + 'gt', 'w')

for u in uid_test:
    #num_items_all_test_u = test_all.getrow(u).indices.shape[0]
    #items_all_test_u = test_all.getrow(u).indices
    known_positives = test.getrow(u).indices
    scores = model.predict(u, np.unique(test_all.col))
    top_items = pid_all_test[np.argsort(-scores)]
    export_pred.write(' '.join(map(str, [u] + list(top_items))) + '\n')
    export_true.write(' '.join(map(str, [u] + list(known_positives))) + '\n')
print('done')

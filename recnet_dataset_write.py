import numpy as np
import pyximport
pyximport.install()

raw_data = np.loadtxt('/Users/sumitsidana/embcs/dat.outbrainchallenge.withindexedusers.withreplacedrating', delimiter=',')

from dataset_write import TripletsDataset

ds = TripletsDataset(raw_data, threshold_user=60, rnd_seed=42)
ds.train_test_split(n_train=50)
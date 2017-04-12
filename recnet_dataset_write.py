import numpy as np
import pyximport
pyximport.install()

raw_data = np.loadtxt('/data/sidana/nnmf_ranking/archive_version/ml20m/input_data/ratings.csv', delimiter=',')

from dataset_write import TripletsDataset

ds = TripletsDataset(raw_data, threshold_user=60, rnd_seed=42)
ds.train_test_split(n_train=50)
import sys
import numpy as np
import itertools
import scipy.sparse as sp

def _get_data(inputPath):
    """
    Return the raw lines of the train and test files.
    """

    path = inputPath

    #with zipfile.ZipFile(path) as datafile:
    datafileTrain =  open(path+"/train_all_raw.csv",'r')
    #datafileTrain =  open(path+"/train.csv",'r')
    datafileTest  =  open(path+"/test_all_raw.csv",'r')
    #datafileTest  =  open(path+"/test.csv",'r')
    return (datafileTrain.read().split('\n'),datafileTest.read().split('\n'))

def _parse(data):
    """
    Parse movielens dataset lines.
    """

    for line in data:

        if not line:
            continue

        uid, iid, rating, timestamp = [int(x) for x in line.split(sys.argv[2])]

        yield uid, iid, rating, timestamp

def foo(cols, N):
    c = set(range(N))
    c = c.difference(cols)
    return np.random.choice(list(c),size=len(cols), replace=True)

def _build_interaction_matrix(rows, cols, data, score):

    mat = sp.lil_matrix((rows, cols), dtype=np.int32)

    for uid, iid, rating, timestamp in data:
        # Let's assume only really good things are positives
        if rating >= score:
            mat[uid, iid] = 1.0

    return mat.tocoo()

def get_triplets(mat):
    # M1 = mat.tolil()
    # randval = [foo(c, M1.shape[1]) for c in M1.rows]
    # M1.data[:] = randval
    # Mo = M1.tocoo()
    # return_mat = np.column_stack((Mo.row, Mo.col, Mo.data))
    # return return_mat[:, 0], return_mat[:, 1], return_mat[:, 2]
    return mat.row, mat.col, np.random.randint(mat.shape[1], size=len(mat.row))

def get_movielens_positive_data(inputPath):
    """
    Return (train_interactions, test_interactions).
    """

    train_data, test_data = _get_data(inputPath)

    uids = set()
    iids = set()

    for uid, iid, rating, timestamp in itertools.chain(_parse(train_data),
                                                       _parse(test_data)):
        uids.add(uid)
        iids.add(iid)

    rows = max(uids) + 1
    cols = max(iids) + 1

    return (_build_interaction_matrix(rows, cols, _parse(train_data), 4.0),
            _build_interaction_matrix(rows, cols, _parse(test_data), 4.0))


def get_movielens_data(inputPath):
    """
    Return (train_interactions, test_interactions).
    """

    train_data, test_data = _get_data(inputPath)

    uids = set()
    iids = set()

    for uid, iid, rating, timestamp in itertools.chain(_parse(train_data),
                                                       _parse(test_data)):
        uids.add(uid)
        iids.add(iid)

    rows = max(uids) + 1
    cols = max(iids) + 1

    return (_build_interaction_matrix(rows, cols, _parse(train_data), 0.0),
            _build_interaction_matrix(rows, cols, _parse(test_data), 0.0))

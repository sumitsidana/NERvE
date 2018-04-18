import numpy as np
cimport numpy as np


cdef class CachedRandomizer(object):
    cdef long blob_size
    cdef long high_value
    cdef long ptr
    cdef np.int32_t[:] blob



    def __init__(CachedRandomizer self, long high, long blob_size=10000000):
        self.blob_size = blob_size
        self.high_value = high
        self.reset_state()
    
    cdef reset_state(CachedRandomizer self):
        self.ptr = 0
        self.blob = np.random.randint(0, self.high_value, self.blob_size).astype(np.int32).copy()
        
    cdef int sample_c(CachedRandomizer self):
        cdef int retval = 0
        if self.ptr >= self.blob_size:
            self.reset_state()
        retval = self.blob[self.ptr]
        self.ptr += 1
        return retval
    
    def sample(CachedRandomizer self, k=None):
        cdef int val = 0
        cdef int ck = 0
        val = self.sample_c()
        if k is not None:
            ck = k
            while val >= ck:
                val = self.sample_c()
        return val


cdef class CachedSampler2from5(object):
    cdef CachedRandomizer rnd
    def __init__(self, long blob_size=10000000):
        self.rnd = CachedRandomizer(5, blob_size)
    
    cdef int sample_while(self, int max_val, int prev):
        cdef int val
        val = self.rnd.sample_c()
        while val >= max_val or val==prev:
            val = self.rnd.sample_c()
        return val
    
    def sample(self, arr):
        cdef int k = len(arr)
        cdef int ret1 = self.sample_while(max_val=k, prev=-1)
        cdef int ret2 = self.sample_while(max_val=k, prev=ret1)
        return (arr[ret1], arr[ret2])
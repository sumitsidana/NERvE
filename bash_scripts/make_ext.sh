#!/bin/bash
cython cachedrandom.pyx
python3 setup.py build_ext --inplace
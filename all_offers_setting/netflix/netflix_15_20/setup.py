from distutils.core import setup, Extension
from Cython.Build import cythonize
import numpy

setup(
    ext_modules=[
        Extension("cachedrandom", ["cachedrandom.c"],
                  include_dirs=[numpy.get_include()]),
    ],
)
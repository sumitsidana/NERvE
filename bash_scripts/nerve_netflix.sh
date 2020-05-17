#!/usr/bin/env bash
mkdir -p /data/sidana/recnet/netflix/recnet/vectors
python3 train_test_split.py netflix 0 1 2 16 0.05

./writerelevancevectorrecnet.sh netflix 01 one
./writerelevancevectorrecnet.sh netflix 01 five
./writerelevancevectorrecnet.sh netflix 01 ten

python3 train_test_split.py netflix 1 0 14 64 0.05

./writerelevancevectorrecnet.sh netflix 10 one
./writerelevancevectorrecnet.sh netflix 10 five
./writerelevancevectorrecnet.sh netflix 10 ten

python3 train_test_split.py netflix 1 1 4 32 0.05

./writerelevancevectorrecnet.sh netflix 11 one
./writerelevancevectorrecnet.sh netflix 11 five
./writerelevancevectorrecnet.sh netflix 11 ten

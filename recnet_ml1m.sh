#!/usr/bin/env bash
mkdir -p /data/sidana/recnet/ml1m/recnet/vectors
python3 train_test_split.py ml1m 0 1 2 64

./writerelevancevectorrecnet.sh ml1m 01 one
./writerelevancevectorrecnet.sh ml1m 01 five
./writerelevancevectorrecnet.sh ml1m 01 ten

python3 train_test_split.py ml1m 1 0 14 32

./writerelevancevectorrecnet.sh ml1m 10 one
./writerelevancevectorrecnet.sh ml1m 10 five
./writerelevancevectorrecnet.sh ml1m 10 ten

python3 train_test_split.py ml1m 1 1 3 64

./writerelevancevectorrecnet.sh ml1m 11 one
./writerelevancevectorrecnet.sh ml1m 11 five
./writerelevancevectorrecnet.sh ml1m 11 ten

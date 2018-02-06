#!/usr/bin/env bash
mkdir -p /data/sidana/recnet/ml100k/recnet/vectors
python3 train_test_split.py ml100k 0 1 14 32

./writerelevancevectorrecnet.sh ml100k 01 one
./writerelevancevectorrecnet.sh ml100k 01 five
./writerelevancevectorrecnet.sh ml100k 01 ten

python3 train_test_split.py ml100k 1 0 2 64

./writerelevancevectorrecnet.sh ml100k 10 one
./writerelevancevectorrecnet.sh ml100k 10 five
./writerelevancevectorrecnet.sh ml100k 10 ten

python3 train_test_split.py ml100k 1 1 3 64

./writerelevancevectorrecnet.sh ml100k 11 one
./writerelevancevectorrecnet.sh ml100k 11 five
./writerelevancevectorrecnet.sh ml100k 11 ten

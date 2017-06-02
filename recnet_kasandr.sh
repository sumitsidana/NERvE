mkdir -p /data/sidana/recnet_draft/kasandr/recnet/vectors
python3 train_test_split.py kasandr 0 1
./writerelevancevectorrecnet.sh kasandr 01 one
./writerelevancevectorrecnet.sh kasandr 01 five
./writerelevancevectorrecnet.sh kasandr 01 ten
python3 train_test_split.py kasandr 1 0
./writerelevancevectorrecnet.sh kasandr 10 one
./writerelevancevectorrecnet.sh kasandr 10 five
./writerelevancevectorrecnet.sh kasandr 10 ten
python3 train_test_split.py kasandr 1 1
./writerelevancevectorrecnet.sh kasandr 11 one
./writerelevancevectorrecnet.sh kasandr 11 five
./writerelevancevectorrecnet.sh kasandr 11 ten

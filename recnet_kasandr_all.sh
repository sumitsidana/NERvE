mkdir -p /data/sidana/recnet_draft/kasandr/recnet_all/vectors
python3 train_test_split_all.py kasandr 0 1
./writerelevancevectorrecnet_all.sh kasandr 01 one
./writerelevancevectorrecnet_all.sh kasandr 01 five
./writerelevancevectorrecnet_all.sh kasandr 01 ten
python3 train_test_split_all.py kasandr 1 0
./writerelevancevectorrecnet_all.sh kasandr 10 one
./writerelevancevectorrecnet_all.sh kasandr 10 five
./writerelevancevectorrecnet_all.sh kasandr 10 ten
python3 train_test_split_all.py kasandr 1 1
./writerelevancevectorrecnet_all.sh kasandr 11 one
./writerelevancevectorrecnet_all.sh kasandr 11 five
./writerelevancevectorrecnet_all.sh kasandr 11 ten

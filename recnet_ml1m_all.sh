mkdir -p /data/sidana/recnet_draft/ml1m/recnet_all/vectors
python3 train_test_split_all.py ml1m 0 1
./writerelevancevectorrecnet_all.sh ml1m 01 one
./writerelevancevectorrecnet_all.sh ml1m 01 five
./writerelevancevectorrecnet_all.sh ml1m 01 ten
python3 train_test_split_all.py ml1m 1 0
./writerelevancevectorrecnet_all.sh ml1m 10 one
./writerelevancevectorrecnet_all.sh ml1m 10 five
./writerelevancevectorrecnet_all.sh ml1m 10 ten
python3 train_test_split_all.py ml1m 1 1
./writerelevancevectorrecnet_all.sh ml1m 11 one
./writerelevancevectorrecnet_all.sh ml1m 11 five
./writerelevancevectorrecnet_all.sh ml1m 11 ten

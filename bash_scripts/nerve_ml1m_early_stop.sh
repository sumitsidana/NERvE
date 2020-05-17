mkdir -p /data/sidana/recnet_draft/ml1m/recnet_earlystop/vectors
python3 train_test_split.py ml1m 0 1
./writerelevancevectorrecnet.sh ml1m 01 one
./writerelevancevectorrecnet.sh ml1m 01 five
./writerelevancevectorrecnet.sh ml1m 01 ten
python3 train_test_split.py ml1m 1 0
./writerelevancevectorrecnet.sh ml1m 10 one
./writerelevancevectorrecnet.sh ml1m 10 five
./writerelevancevectorrecnet.sh ml1m 10 ten
python3 train_test_split.py ml1m 1 1
./writerelevancevectorrecnet.sh ml1m 11 one
./writerelevancevectorrecnet.sh ml1m 11 five
./writerelevancevectorrecnet.sh ml1m 11 ten
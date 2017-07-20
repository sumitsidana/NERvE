mkdir -p /data/sidana/recnet_draft/ml100k/recnet_all/vectors
python3 train_test_split_all.py ml100k 0 1
./writerelevancevectorrecnet_all.sh ml100k 01 one
./writerelevancevectorrecnet_all.sh ml100k 01 five
./writerelevancevectorrecnet_all.sh ml100k 01 ten
python3 train_test_split_all.py ml100k 1 0
./writerelevancevectorrecnet_all.sh ml100k 10 one
./writerelevancevectorrecnet_all.sh ml100k 10 five
./writerelevancevectorrecnet_all.sh ml100k 10 ten
python3 train_test_split_all.py ml100k 1 1
./writerelevancevectorrecnet_all.sh ml100k 11 one
./writerelevancevectorrecnet_all.sh ml100k 11 five
./writerelevancevectorrecnet_all.sh ml100k 11 ten
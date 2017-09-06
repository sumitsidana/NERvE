mkdir -p /data/sidana/recnet_draft/cold_start/ucs/ml100k/recnet_all/vectors
python3 train_test_split_all_cold_start_ucs.py ml100k 0 1
./writerelevancevectorrecnet_all_cold_start_ucs.sh ml100k 01 one
./writerelevancevectorrecnet_all_cold_start_ucs.sh ml100k 01 five
./writerelevancevectorrecnet_all_cold_start_ucs.sh ml100k 01 ten
python3 train_test_split_all_cold_start_ucs.py ml100k 1 0
./writerelevancevectorrecnet_all_cold_start_ucs.sh ml100k 10 one
./writerelevancevectorrecnet_all_cold_start_ucs.sh ml100k 10 five
./writerelevancevectorrecnet_all_cold_start_ucs.sh ml100k 10 ten
python3 train_test_split_all_cold_start_ucs.py ml100k 1 1
./writerelevancevectorrecnet_all_cold_start_ucs.sh ml100k 11 one
./writerelevancevectorrecnet_all_cold_start_ucs.sh ml100k 11 five
./writerelevancevectorrecnet_all_cold_start_ucs.sh ml100k 11 ten
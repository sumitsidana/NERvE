mkdir -p /data/sidana/recnet_draft/cold_start/ucs/netflix/recnet_all/vectors
python3 train_test_split_all_cold_start_ucs.py netflix 0 1
./writerelevancevectorrecnet_all_cold_start_ucs.sh netflix 01 one
./writerelevancevectorrecnet_all_cold_start_ucs.sh netflix 01 five
./writerelevancevectorrecnet_all_cold_start_ucs.sh netflix 01 ten
python3 train_test_split_all_cold_start_ucs.py netflix 1 0
./writerelevancevectorrecnet_all_cold_start_ucs.sh netflix 10 one
./writerelevancevectorrecnet_all_cold_start_ucs.sh netflix 10 five
./writerelevancevectorrecnet_all_cold_start_ucs.sh netflix 10 ten
python3 train_test_split_all_cold_start_ucs.py netflix 1 1
./writerelevancevectorrecnet_all_cold_start_ucs.sh netflix 11 one
./writerelevancevectorrecnet_all_cold_start_ucs.sh netflix 11 five
./writerelevancevectorrecnet_all_cold_start_ucs.sh netflix 11 ten
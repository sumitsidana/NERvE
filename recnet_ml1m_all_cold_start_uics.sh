mkdir -p /data/sidana/recnet_draft/cold_start/uics/ml1m/recnet_all/vectors
python3 train_test_split_all_cold_start_uics.py ml1m 0 1
./writerelevancevectorrecnet_all_cold_start_uics.sh ml1m 01 one
./writerelevancevectorrecnet_all_cold_start_uics.sh ml1m 01 five
./writerelevancevectorrecnet_all_cold_start_uics.sh ml1m 01 ten
python3 train_test_split_all_cold_start_uics.py ml1m 1 0
./writerelevancevectorrecnet_all_cold_start_uics.sh ml1m 10 one
./writerelevancevectorrecnet_all_cold_start_uics.sh ml1m 10 five
./writerelevancevectorrecnet_all_cold_start_uics.sh ml1m 10 ten
python3 train_test_split_all_cold_start_uics.py ml1m 1 1
./writerelevancevectorrecnet_all_cold_start_uics.sh ml1m 11 one
./writerelevancevectorrecnet_all_cold_start_uics.sh ml1m 11 five
./writerelevancevectorrecnet_all_cold_start_uics.sh ml1m 11 ten

mkdir -p /data/sidana/recnet_draft/param_tune/kasandr/recnet/vectors
python3 recnet_param_tune.py kasandr 0 1
./writerelevancevectorrecnet_param_tune.sh kasandr 01 one
./writerelevancevectorrecnet_param_tune.sh kasandr 01 five
./writerelevancevectorrecnet_param_tune.sh kasandr 01 ten
python3 recnet_param_tune.py kasandr 1 0
./writerelevancevectorrecnet_param_tune.sh kasandr 10 one
./writerelevancevectorrecnet_param_tune.sh kasandr 10 five
./writerelevancevectorrecnet_param_tune.sh kasandr 10 ten
python3 recnet_param_tune.py kasandr 1 1
./writerelevancevectorrecnet_param_tune.sh kasandr 11 one
./writerelevancevectorrecnet_param_tune.sh kasandr 11 five
./writerelevancevectorrecnet_param_tune.sh kasandr 11 ten

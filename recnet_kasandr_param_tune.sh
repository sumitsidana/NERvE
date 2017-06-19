#!/usr/bin/env bash
mkdir -p /data/sidana/recnet_draft/param_tune/kasandr/recnet/vectors
END=1
for  latent_factor in $(seq 1 $END); do
    python3 recnet_param_tune.py kasandr 0 1 $latent_factor
    ./writerelevancevectorrecnet_param_tune.sh kasandr 01 one
    ./writerelevancevectorrecnet_param_tune.sh kasandr 01 five
    ./writerelevancevectorrecnet_param_tune.sh kasandr 01 ten 
    python3 recnet_param_tune.py kasandr 1 0 $latent_factor
    ./writerelevancevectorrecnet_param_tune.sh kasandr 10 one
    ./writerelevancevectorrecnet_param_tune.sh kasandr 10 five
    ./writerelevancevectorrecnet_param_tune.sh kasandr 10 ten
    python3 recnet_param_tune.py kasandr 1 1 $latent_factor
    ./writerelevancevectorrecnet_param_tune.sh kasandr 11 one
    ./writerelevancevectorrecnet_param_tune.sh kasandr 11 five
    ./writerelevancevectorrecnet_param_tune.sh kasandr 11 ten
done

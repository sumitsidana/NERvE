#!/usr/bin/env bash
mkdir -p /data/sidana/recnet_draft/param_tune/ml100k/recnet/vectors
END=100
for  latent_factor in $(seq 1 $END); do
    echo -e "Latent Factor: $latent_factor" >> /data/sidana/recnet_draft/param_tune/ml100k/recnet/results
    python3 recnet_param_tune.py ml100k 0 1 $latent_factor
    
    echo -e "alpha: 0, beta: 1" >>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results
    echo -e -n "map@1:">>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results
    ./writerelevancevectorrecnet_param_tune.sh ml100k 01 one >>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results
    echo -e -n "map@5: ">>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results
    ./writerelevancevectorrecnet_param_tune.sh ml100k 01 five>>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results
    echo -e -n "map@10: " >>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results
    ./writerelevancevectorrecnet_param_tune.sh ml100k 01 ten >>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results

    python3 recnet_param_tune.py ml100k 1 0 $latent_factor

    echo -e "alpha: 1, beta: 0\n" >>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results
    echo -e -n "map@1:">>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results
    ./writerelevancevectorrecnet_param_tune.sh ml100k 10 one>>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results
    echo -e -n "map@5: ">>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results
    ./writerelevancevectorrecnet_param_tune.sh ml100k 10 five>>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results
    echo -e -n "map@10: " >>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results
    ./writerelevancevectorrecnet_param_tune.sh ml100k 10 ten>>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results

    python3 recnet_param_tune.py ml100k 1 1 $latent_factor

   echo -e "alpha: 1, beta: 1" >>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results
   echo -e -n "map@1:">>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results
    ./writerelevancevectorrecnet_param_tune.sh ml100k 11 one>>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results
   echo -e -n "map@5: ">>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results
    ./writerelevancevectorrecnet_param_tune.sh ml100k 11 five>>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results
   echo -e -n "map@10: " >>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results
    ./writerelevancevectorrecnet_param_tune.sh ml100k 11 ten>>/data/sidana/recnet_draft/param_tune/ml100k/recnet/results
done

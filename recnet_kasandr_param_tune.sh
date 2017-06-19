#!/usr/bin/env bash
mkdir -p /data/sidana/recnet_draft/param_tune/kasandr/recnet/vectors
END=1
for  latent_factor in $(seq 1 $END); do
    echo -e "Latent Factor: $latent_factor\n" >> /data/sidana/recnet_draft/param_tune/kasandr/recnet/results
    python3 recnet_param_tune.py kasandr 0 1 $latent_factor
    
    echo -e "alpha: 0, beta: 1\n" >>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results
    echo -e "map@1:">>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results
    ./writerelevancevectorrecnet_param_tune.sh kasandr 01 one >>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results
    echo -e "\nmap@5: ">>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results
    ./writerelevancevectorrecnet_param_tune.sh kasandr 01 five>>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results
    echo -e "\nmap@10: " >>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results
    ./writerelevancevectorrecnet_param_tune.sh kasandr 01 ten >>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results

    python3 recnet_param_tune.py kasandr 1 0 $latent_factor

    echo -e "\nalpha: 1, beta: 0\n" >>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results
    echo -e "map@1:">>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results
    ./writerelevancevectorrecnet_param_tune.sh kasandr 10 one>>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results
    echo -e "\nmap@5: ">>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results
    ./writerelevancevectorrecnet_param_tune.sh kasandr 10 five>>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results
    echo -e "\nmap@10: " >>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results
    ./writerelevancevectorrecnet_param_tune.sh kasandr 10 ten>>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results

    python3 recnet_param_tune.py kasandr 1 1 $latent_factor

   echo -e "alpha: 1, beta: 1\n" >>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results
   echo -e "map@1:">>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results
    ./writerelevancevectorrecnet_param_tune.sh kasandr 11 one>>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results
   echo -e "\nmap@5: ">>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results
    ./writerelevancevectorrecnet_param_tune.sh kasandr 11 five>>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results
   echo -e "\nmap@10: " >>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results
    ./writerelevancevectorrecnet_param_tune.sh kasandr 11 ten>>/data/sidana/recnet_draft/param_tune/kasandr/recnet/results
done

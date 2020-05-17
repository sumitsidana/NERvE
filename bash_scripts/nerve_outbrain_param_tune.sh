#!/usr/bin/env bash
mkdir -p /data/sidana/recnet_draft/param_tune/outbrain/recnet/vectors

end_lf=20
reg_params="0.0001 0.001 0.005 0.01 0.05"
hidden_units="16 32 64"

for  latent_factor in $(seq 1 $end_lf); do
    for reg in $reg_params; do
        for num_units in $hidden_units; do

            echo -e "Latent Factor: $latent_factor Regularization: $reg Hidden Units: $num_units" >> /data/sidana/recnet_draft/param_tune/outbrain/recnet/results

            python3 recnet_param_tune.py outbrain 0 1 $latent_factor $reg $num_units

            echo -e "alpha: 0, beta: 1" >>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results
            echo -e -n "map@1: ">>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results
            ./writerelevancevectorrecnet_param_tune.sh outbrain 01 one >>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results
            echo -e -n "map@5: ">>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results
            ./writerelevancevectorrecnet_param_tune.sh outbrain 01 five>>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results
            echo -e -n "map@10:" >>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results
            ./writerelevancevectorrecnet_param_tune.sh outbrain 01 ten >>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results

            python3 recnet_param_tune.py outbrain 1 0 $latent_factor $reg $num_units

            echo -e "alpha: 1, beta: 0\n" >>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results
            echo -e -n "map@1: ">>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results
            ./writerelevancevectorrecnet_param_tune.sh outbrain 10 one>>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results
            echo -e -n "map@5: ">>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results
            ./writerelevancevectorrecnet_param_tune.sh outbrain 10 five>>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results
            echo -e -n "map@10:" >>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results
            ./writerelevancevectorrecnet_param_tune.sh outbrain 10 ten>>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results

            python3 recnet_param_tune.py outbrain 1 1 $latent_factor $reg $num_units

           echo -e "alpha: 1, beta: 1" >>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results
           echo -e -n "map@1: ">>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results
            ./writerelevancevectorrecnet_param_tune.sh outbrain 11 one>>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results
           echo -e -n "map@5: ">>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results
            ./writerelevancevectorrecnet_param_tune.sh outbrain 11 five>>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results
           echo -e -n "map@10:" >>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results
            ./writerelevancevectorrecnet_param_tune.sh outbrain 11 ten>>/data/sidana/recnet_draft/param_tune/outbrain/recnet/results
        done
    done
done

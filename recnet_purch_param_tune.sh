#!/usr/bin/env bash
mkdir -p /data/sidana/recnet/param_tune/recnet/recnet/vectors

end_lf=20
reg_params="0.0001 0.001 0.005 0.01 0.05"
hidden_units="16 32 64"

for  latent_factor in $(seq 1 $end_lf); do
    for reg in $reg_params; do
        for num_units in $hidden_units; do

            echo -e "Latent Factor: $latent_factor Regularization: $reg Hidden Units: $num_units" >> /data/sidana/recnet/param_tune/recnet/recnet/results

            python3 recnet_param_tune.py recnet 0 1 $latent_factor $reg $num_units

            echo -e "alpha: 0, beta: 1" >>/data/sidana/recnet/param_tune/recnet/recnet/results
            echo -e -n "map@1: ">>/data/sidana/recnet/param_tune/recnet/recnet/results
            ./writerelevancevectorrecnet_param_tune.sh recnet 01 one >>/data/sidana/recnet/param_tune/recnet/recnet/results
            echo -e -n "map@5: ">>/data/sidana/recnet/param_tune/recnet/recnet/results
            ./writerelevancevectorrecnet_param_tune.sh recnet 01 five>>/data/sidana/recnet/param_tune/recnet/recnet/results
            echo -e -n "map@10:" >>/data/sidana/recnet/param_tune/recnet/recnet/results
            ./writerelevancevectorrecnet_param_tune.sh recnet 01 ten >>/data/sidana/recnet/param_tune/recnet/recnet/results

            python3 recnet_param_tune.py recnet 1 0 $latent_factor $reg $num_units

            echo -e "alpha: 1, beta: 0" >>/data/sidana/recnet/param_tune/recnet/recnet/results
            echo -e -n "map@1: ">>/data/sidana/recnet/param_tune/recnet/recnet/results
            ./writerelevancevectorrecnet_param_tune.sh recnet 10 one>>/data/sidana/recnet/param_tune/recnet/recnet/results
            echo -e -n "map@5: ">>/data/sidana/recnet/param_tune/recnet/recnet/results
            ./writerelevancevectorrecnet_param_tune.sh recnet 10 five>>/data/sidana/recnet/param_tune/recnet/recnet/results
            echo -e -n "map@10:" >>/data/sidana/recnet/param_tune/recnet/recnet/results
            ./writerelevancevectorrecnet_param_tune.sh recnet 10 ten>>/data/sidana/recnet/param_tune/recnet/recnet/results

            python3 recnet_param_tune.py recnet 1 1 $latent_factor $reg $num_units

           echo -e "alpha: 1, beta: 1" >>/data/sidana/recnet/param_tune/recnet/recnet/results
           echo -e -n "map@1: ">>/data/sidana/recnet/param_tune/recnet/recnet/results
            ./writerelevancevectorrecnet_param_tune.sh recnet 11 one>>/data/sidana/recnet/param_tune/recnet/recnet/results
           echo -e -n "map@5: ">>/data/sidana/recnet/param_tune/recnet/recnet/results
            ./writerelevancevectorrecnet_param_tune.sh recnet 11 five>>/data/sidana/recnet/param_tune/recnet/recnet/results
           echo -e -n "map@10:" >>/data/sidana/recnet/param_tune/recnet/recnet/results
            ./writerelevancevectorrecnet_param_tune.sh recnet 11 ten>>/data/sidana/recnet/param_tune/recnet/recnet/results
        done
    done
done

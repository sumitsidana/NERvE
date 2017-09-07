#!/usr/bin/env bash
mkdir -p /data/sidana/recnet_draft/ml100k/recnet_alpha/vectors

#end_lf=20
#reg_params="0.0001 0.001 0.005 0.01 0.05"
#hidden_units="16 32 64"

alpha_values="0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9"

#for  batch_num in $(seq 1 $end_lf); do
#    for reg in _params; do
#        for num_units in $hidden_units; do

for alpha_value in $alpha_values; do
            beta_value=$((1 - alpha_value))

            echo -e "alpha_value: $alpha_value " >> /data/sidana/recnet_draft/ml100k/recnet_alpha/results

            python3 train_test_split_alpha.py ml100k $alpha_value $beta_value
            echo -e -n "map@1: ">>/data/sidana/recnet_draft/ml100k/recnet_alpha/results
            ./writerelevancevectortrain_test_split_alpha.sh ml100k one >>/data/sidana/recnet_draft/ml100k/recnet_alpha/results
            echo -e -n "map@5: ">>/data/sidana/recnet_draft/ml100k/recnet_alpha/results
            ./writerelevancevectortrain_test_split_alpha.sh ml100k five>>/data/sidana/recnet_draft/ml100k/recnet_alpha/results
            echo -e -n "map@10:" >>/data/sidana/recnet_draft/ml100k/recnet_alpha/results
            ./writerelevancevectortrain_test_split_alpha.sh ml100k ten >>/data/sidana/recnet_draft/ml100k/recnet_alpha/results

        done
#    done
#done

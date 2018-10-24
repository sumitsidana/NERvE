#!/usr/bin/env bash
mkdir -p /data/sidana/recnet/recnet_alpha_all_offers_setting/ml1m/vectors

#end_lf=20
#reg_params="0.0001 0.001 0.005 0.01 0.05"
#hidden_units="16 32 64"

alpha_values="0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9"

#for  batch_num in $(seq 1 $end_lf); do
#    for reg in _params; do
#        for num_units in $hidden_units; do

for alpha_value in $alpha_values; do


            echo -e "alpha_value: $alpha_value " >> /data/sidana/recnet/recnet_alpha_all_offers_setting/ml1m/results
            beta_value="$(echo 1.0 - $alpha_value|bc)"

            python3 train_test_split_alpha_all.py ml1m $alpha_value $beta_value 1 0.001 32
            echo -e -n "map@1: ">>/data/sidana/recnet/recnet_alpha_all_offers_setting/ml1m/results
            ./writerelevancevectortrain_test_split_alpha_all.sh ml1m one >>/data/sidana/recnet/recnet_alpha_all_offers_setting/ml1m/results
            echo -e -n "map@5: ">>/data/sidana/recnet/recnet_alpha_all_offers_setting/ml1m/results
            ./writerelevancevectortrain_test_split_alpha_all.sh ml1m five>>/data/sidana/recnet/recnet_alpha_all_offers_setting/ml1m/results
            echo -e -n "map@10:" >>/data/sidana/recnet/recnet_alpha_all_offers_setting/ml1m/results
            ./writerelevancevectortrain_test_split_alpha_all.sh ml1m ten >>/data/sidana/recnet/recnet_alpha_all_offers_setting/ml1m/results

        done
#    done
#done
#!/usr/bin/env bash
mkdir -p /data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/vectors

end_lf=20
reg_params="0.0001 0.001 0.005 0.01 0.05"
hidden_units="16 32 64"

for  latent_factor in $(seq 1 $end_lf); do
    for reg in $reg_params; do
        for num_units in $hidden_units; do

            echo -e "Latent Factor: $latent_factor Regularization: $reg Hidden Units: $num_units" >> /data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results

            python3 recnet_ml100k_param_tune_all.py ml100k 0 1 $latent_factor $reg $num_units
            cd ../../

            echo -e "alpha: 0, beta: 1" >>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results
            echo -e -n "map@1: ">>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results
            ./writerelevancevectorrecnet_param_tune_all.sh ml100k 01 one >>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results
            echo -e -n "map@5: ">>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results
            ./writerelevancevectorrecnet_param_tune_all.sh ml100k 01 five>>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results
            echo -e -n "map@10:" >>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results
            ./writerelevancevectorrecnet_param_tune_all.sh ml100k 01 ten >>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results

            cd all_offers_setting/ml100k

            python3 recnet_ml100k_param_tune_all.py ml100k 1 0 $latent_factor $reg $num_units
            cd ../../

            echo -e "alpha: 1, beta: 0" >>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results
            echo -e -n "map@1: ">>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results
            ./writerelevancevectorrecnet_param_tune_all.sh ml100k 10 one>>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results
            echo -e -n "map@5: ">>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results
            ./writerelevancevectorrecnet_param_tune_all.sh ml100k 10 five>>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results
            echo -e -n "map@10:" >>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results
            ./writerelevancevectorrecnet_param_tune_all.sh ml100k 10 ten>>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results

            cd all_offers_setting/ml100k

            python3 recnet_ml100k_param_tune_all.py ml100k 1 1 $latent_factor $reg $num_units
            cd ../../

           echo -e "alpha: 1, beta: 1" >>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results
           echo -e -n "map@1: ">>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results
            ./writerelevancevectorrecnet_param_tune_all.sh ml100k 11 one>>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results
           echo -e -n "map@5: ">>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results
            ./writerelevancevectorrecnet_param_tune_all.sh ml100k 11 five>>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results
           echo -e -n "map@10:" >>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results
            ./writerelevancevectorrecnet_param_tune_all.sh ml100k 11 ten>>/data/sidana/recnet/all_test_param_tune/ml100k/recnet_all/results

            cd all_offers_setting/ml100k
        done
    done
done

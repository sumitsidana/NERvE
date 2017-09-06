#!/usr/bin/env bash
mkdir -p /data/sidana/recnet_draft/ml100k/recnet_batches/vectors

#end_lf=20
#reg_params="0.0001 0.001 0.005 0.01 0.05"
#hidden_units="16 32 64"

num_batches="1000 2000 3000 4000 5000 6000 7000 8000 9000 10000"

#for  batch_num in $(seq 1 $end_lf); do
#    for reg in _params; do
#        for num_units in $hidden_units; do

for batch_num in $num_batches; do

            echo -e "number of batches: $batch_num " >> /data/sidana/recnet_draft/ml100k/recnet_batches/results

            python3 train_test_split_batches.py ml100k 0 1 $batch_num

            echo -e "alpha: 0, beta: 1" >>/data/sidana/recnet_draft/ml100k/recnet_batches/results
            echo -e -n "map@1: ">>/data/sidana/recnet_draft/ml100k/recnet_batches/results
            ./writerelevancevectortrain_test_split_batches.sh ml100k 01 one >>/data/sidana/recnet_draft/ml100k/recnet_batches/results
            echo -e -n "map@5: ">>/data/sidana/recnet_draft/ml100k/recnet_batches/results
            ./writerelevancevectortrain_test_split_batches.sh ml100k 01 five>>/data/sidana/recnet_draft/ml100k/recnet_batches/results
            echo -e -n "map@10:" >>/data/sidana/recnet_draft/ml100k/recnet_batches/results
            ./writerelevancevectortrain_test_split_batches.sh ml100k 01 ten >>/data/sidana/recnet_draft/ml100k/recnet_batches/results

            python3 train_test_split_batches.py ml100k 1 0 $batch_num

            echo -e "alpha: 1, beta: 0" >>/data/sidana/recnet_draft/ml100k/recnet_batches/results
            echo -e -n "map@1: ">>/data/sidana/recnet_draft/ml100k/recnet_batches/results
            ./writerelevancevectortrain_test_split_batches.sh ml100k 10 one>>/data/sidana/recnet_draft/ml100k/recnet_batches/results
            echo -e -n "map@5: ">>/data/sidana/recnet_draft/ml100k/recnet_batches/results
            ./writerelevancevectortrain_test_split_batches.sh ml100k 10 five>>/data/sidana/recnet_draft/ml100k/recnet_batches/results
            echo -e -n "map@10:" >>/data/sidana/recnet_draft/ml100k/recnet_batches/results
            ./writerelevancevectortrain_test_split_batches.sh ml100k 10 ten>>/data/sidana/recnet_draft/ml100k/recnet_batches/results

            python3 train_test_split_batches.py ml100k 1 1 $batch_num

           echo -e "alpha: 1, beta: 1" >>/data/sidana/recnet_draft/ml100k/recnet_batches/results
           echo -e -n "map@1: ">>/data/sidana/recnet_draft/ml100k/recnet_batches/results
            ./writerelevancevectortrain_test_split_batches.sh ml100k 11 one>>/data/sidana/recnet_draft/ml100k/recnet_batches/results
           echo -e -n "map@5: ">>/data/sidana/recnet_draft/ml100k/recnet_batches/results
            ./writerelevancevectortrain_test_split_batches.sh ml100k 11 five>>/data/sidana/recnet_draft/ml100k/recnet_batches/results
           echo -e -n "map@10:" >>/data/sidana/recnet_draft/ml100k/recnet_batches/results
            ./writerelevancevectortrain_test_split_batches.sh ml100k 11 ten>>/data/sidana/recnet_draft/ml100k/recnet_batches/results
        done
#    done
#done

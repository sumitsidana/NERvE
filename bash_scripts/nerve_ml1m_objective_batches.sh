#!/usr/bin/env bash

#end_lf=20
#reg_params="0.0001 0.001 0.005 0.01 0.05"
#hidden_units="16 32 64"

num_batches="1000 2000 3000 4000 5000 6000 7000 8000 9000 10000"

#for  batch_num in $(seq 1 $end_lf); do
#    for reg in _params; do
#        for num_units in $hidden_units; do

for batch_num in $num_batches; do

           echo -e "number of batches: $batch_num " >> /data/sidana/recnet_draft/ml1m/recnet_objective_batches/results

           echo -e "alpha: 0, beta: 1" >>/data/sidana/recnet_draft/ml1m/recnet_objective_batches/results

           python3 train_test_split_objective_batches.py ml1m 0 1 $batch_num >> /data/sidana/recnet_draft/ml1m/recnet_objective_batches/results

           echo -e "alpha: 1, beta: 0" >>/data/sidana/recnet_draft/ml1m/recnet_objective_batches/results

           python3 train_test_split_objective_batches.py ml1m 1 0 $batch_num >> /data/sidana/recnet_draft/ml1m/recnet_objective_batches/results

           echo -e "alpha: 1, beta: 1" >>/data/sidana/recnet_draft/ml1m/recnet_objective_batches/results

           python3 train_test_split_objective_batches.py ml1m 1 1 $batch_num >> /data/sidana/recnet_draft/ml1m/recnet_objective_batches/results

        done
#    done
#done

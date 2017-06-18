./compile.sh

java -cp ./java/ preProcess.WriteTrainTestInputBPRMF /data/recnet_draft/ml1m/bprmf/train_all_raw.csv /data/recnet_draft/ml1m/bprmf/test_all_raw.csv /data/recnet_draft/ml1m/bprmf/train.inputbprmf /data/recnet_draft/ml1m/bprmf/test.inputbprmf

cd /data/recnet_draft/ml1m/bprmf/
cut -f1 test.inputbprmf > test.users
cd /home/sumit/mymedialite/bin/
./item_recommendation --training-file=/data/recnet_draft/ml1m/bprmf/train.inputbprmf --test-file=/data/recnet_draft/ml1m/bprmf/test.inputbprmf --test-users=/data/recnet_draft/ml1m/bprmf/test.users --recommender=BPRMF --in-test-items  --prediction-file=/data/recnet_draft/ml1m/bprmf/prediction_file

cd /home/sumit/nnmf_ranking/nnmf_ranking
./writegroundtruthforbprmf.sh ml1m
./writepredictorforbprmf.sh ml1m

bash ./writerelevancevectorbprmf.sh ml1m one
bash ./writerelevancevectorbprmf.sh ml1m five
bash ./writerelevancevectorbprmf.sh ml1m ten

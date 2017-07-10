./compile.sh

java -cp ./java/ preProcess.WriteTrainTestInputBPRMF /data/recnet_draft/ml100k/bprmf/train_all_raw.csv /data/recnet_draft/ml100k/bprmf/test_all_raw.csv /data/recnet_draft/ml100k/bprmf/train.inputbprmf /data/recnet_draft/ml100k/bprmf/test.inputbprmf

cd /data/recnet_draft/ml100k/bprmf/
cut -f1 test.inputbprmf > test.users
cd /home/sumit/mymedialite/bin/
./item_recommendation --training-file=/data/recnet_draft/ml100k/bprmf/train.inputbprmf --test-file=/data/recnet_draft/ml100k/bprmf/test.inputbprmf --test-users=/data/recnet_draft/ml100k/bprmf/test.users --recommender=BPRMF --recommender-options=reg_u=0.0001 --recommender-options=reg_i=0.0001 --recommender-options=reg_j=0.0001 --recommender-options=learn_rate=0.001 --recommender-options=num_factors=3 --in-test-items  --prediction-file=/data/recnet_draft/ml100k/bprmf/prediction_file

cd /home/sumit/nnmf_ranking/nnmf_ranking
./writegroundtruthforbprmf.sh ml100k
./writepredictorforbprmf.sh ml100k

bash ./writerelevancevectorbprmf.sh ml100k one
bash ./writerelevancevectorbprmf.sh ml100k five
bash ./writerelevancevectorbprmf.sh ml100k ten

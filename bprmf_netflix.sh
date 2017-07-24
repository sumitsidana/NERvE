./compile.sh

java -cp ./java/ preProcess.WriteTrainTestInputBPRMF /data/recnet_draft/netflix/bprmf/train_all_raw.csv /data/recnet_draft/netflix/bprmf/test_all_raw.csv /data/recnet_draft/netflix/bprmf/train.inputbprmf /data/recnet_draft/netflix/bprmf/test.inputbprmf

cd /data/recnet_draft/netflix/bprmf/
cut -f1 test.inputbprmf > test.users
cd /home/sumit/mymedialite/bin/
./item_recommendation --training-file=/data/recnet_draft/netflix/bprmf/train.inputbprmf --test-file=/data/recnet_draft/netflix/bprmf/test.inputbprmf --test-users=/data/recnet_draft/netflix/bprmf/test.users --recommender=BPRMF --recommender-options=reg_u=0.05 --recommender-options=reg_i=0.05 --recommender-options=reg_j=0.05 --recommender-options=learn_rate=0.001 --recommender-options=num_factors=4 --in-test-items  --prediction-file=/data/recnet_draft/netflix/bprmf/prediction_file

cd /home/sumit/recnet_draft
./writegroundtruthforbprmf.sh netflix
./writepredictorforbprmf.sh netflix

bash ./writerelevancevectorbprmf.sh netflix one
bash ./writerelevancevectorbprmf.sh netflix five
bash ./writerelevancevectorbprmf.sh netflix ten

# for all items
#./item_recommendation --training-file=/data/recnet_draft/netflix/bprmf/train.inputbprmf --test-file=/data/recnet_draft/netflix/bprmf/test.inputbprmf --test-users=/data/recnet_draft/netflix/bprmf/test.users --recommender=BPRMF --recommender-options=reg_u=0.01 --recommender-options=reg_i=0.01 --recommender-options=reg_j=0.01 --recommender-options=learn_rate=0.001 --recommender-options=num_factors=18 --in-test-items  --predict-items-number=10 --measures=MAP --repeated-items
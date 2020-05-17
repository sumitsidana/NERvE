./compile.sh

#java -cp ./java/ preProcess.WriteTrainTestInputBPRMF /data/sidana/recnet/kasandr/bprmf/train_all_raw.csv /data/sidana/recnet/kasandr/bprmf/test_all_raw.csv /data/sidana/recnet/kasandr/bprmf/train.inputbprmf /data/sidana/recnet/kasandr/bprmf/test.inputbprmf

cd /data/sidana/recnet/kasandr/bprmf
cut -f1 test.inputbprmf > test.users
sort -n test.users | uniq > test.users.unique
cd /home/sumit/mymedialite/bin/
./item_recommendation --training-file=/data/sidana/recnet/kasandr/bprmf/train.inputbprmf --test-file=/data/sidana/recnet/kasandr/bprmf/test.inputbprmf --test-users=/data/sidana/recnet/kasandr/bprmf/test.users.unique --recommender=BPRMF --recommender-options=reg_u=0.05 --recommender-options=reg_i=0.05 --recommender-options=reg_j=0.05 --recommender-options=learn_rate=0.001 --recommender-options=num_factors=4 --in-test-items  --prediction-file=/data/sidana/recnet/kasandr/bprmf/prediction_file

cd /home/sumit/recnet_draft
./writegroundtruthforbprmf.sh kasandr
./writepredictorforbprmf.sh kasandr

bash ./writerelevancevectorbprmf.sh kasandr one
bash ./writerelevancevectorbprmf.sh kasandr five
bash ./writerelevancevectorbprmf.sh kasandr ten

# for all items
#./item_recommendation --training-file=/data/sidana/recnet/kasandr/bprmf/train.inputbprmf --test-file=/data/sidana/recnet/kasandr/bprmf/test.inputbprmf --test-users=/data/sidana/recnet/kasandr/bprmf/test.users --recommender=BPRMF --recommender-options=reg_u=0.01 --recommender-options=reg_i=0.01 --recommender-options=reg_j=0.01 --recommender-options=learn_rate=0.001 --recommender-options=num_factors=18 --in-test-items  --predict-items-number=10 --measures=MAP --repeated-items

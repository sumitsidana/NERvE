./compile.sh

java -cp ./java/ preProcess.WriteTrainTestInputBPRMF /data/recnet_draft/kasandr/bprmf/train_all_raw.csv /data/recnet_draft/kasandr/bprmf/test_all_raw.csv /data/recnet_draft/kasandr/bprmf/train.inputbprmf /data/recnet_draft/kasandr/bprmf/test.inputbprmf

cd /data/recnet_draft/kasandr/bprmf/
cut -f1 test.inputbprmf > test.users
cd /home/sumit/mymedialite/bin/
./item_recommendation --training-file=/data/recnet_draft/kasandr/bprmf/train.inputbprmf --test-file=/data/recnet_draft/kasandr/bprmf/test.inputbprmf --test-users=/data/recnet_draft/kasandr/bprmf/test.users --recommender=BPRMF --in-test-items  --prediction-file=/data/recnet_draft/kasandr/bprmf/prediction_file

cd /home/sumit/recnet_draft
./writegroundtruthforbprmf.sh kasandr
./writepredictorforbprmf.sh kasandr

bash ./writerelevancevectorbprmf.sh kasandr one
bash ./writerelevancevectorbprmf.sh kasandr five
bash ./writerelevancevectorbprmf.sh kasandr ten
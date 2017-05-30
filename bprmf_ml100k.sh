./compile.sh

java -cp ./java/ preProcess.WriteTrainTestInputBPRMF /data/sidana/recnet_draft/ml100k/bprmf/train_all_raw.csv /data/sidana/recnet_draft/ml100k/bprmf/test_all_raw.csv /data/sidana/recnet_draft/ml100k/bprmf/train.inputbprmf /data/sidana/recnet_draft/ml100k/bprmf/test.inputbprmf

cut -d$'\t' -f1 test.inputbprmf > test.users

sudo ./item_recommendation --training-file=/data/sidana/recnet_draft/ml100k/bprmf/train.inputbprmf --test-file=/data/sidana/recnet_draft/ml100k/bprmf/test.inputbprmf --test-users= --recommender=BPRMF --in-test-items  --prediction-file=/data/sidana/recnet_draft/ml100k/bprmf/prediction_file

./writegroundtruthforbprmf.sh ml100k
./writepredictorforbprmf.sh ml100k

./writerelevancevectorbprmf.sh ml100k one
./writerelevancevectorbprmf.sh ml100k five
./writerelevancevectorbprmf.sh ml100k ten

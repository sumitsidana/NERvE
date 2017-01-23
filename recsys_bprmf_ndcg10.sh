cd ~/mymedialite/bin/
sudo ./item_recommendation --training-file=/data/dat.inputbprmf --recommender=BPRMF --cross-validation=5 --predict-items-number=10 --measures=NDCG
cd -

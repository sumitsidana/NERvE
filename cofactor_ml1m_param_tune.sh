mkdir -p /data/sidana/recnet_draft/ml1m/cofactor/pro
cp /data/sidana/recnet_draft/ml1m/ratings.csv /data/sidana/recnet_draft/ml1m/cofactor/
cd ~/cofactor/src
LANG=en_US.utf8
echo "running cofactor"
python Cofactorization.py "/data/sidana/recnet_draft/ml1m/cofactor/pro"
cd ~/nnmf_ranking/
./writegroundtruthforcofactor.sh ml1m
./writepredictorforcofator.sh ml1m
./writerelevancevectorcofactor.sh ml1m one
./writerelevancevectorcofactor.sh ml1m five
./writerelevancevectorcofactor.sh ml1m ten

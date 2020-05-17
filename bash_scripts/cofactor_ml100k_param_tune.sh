cd ~/cofactor/src
LANG=en_US.utf8
echo "running cofactor"
python Cofactorization.py "/data/sidana/recnet_draft/ml100k/cofactor/pro"
cd ~/nnmf_ranking/
./writegroundtruthforcofactor.sh ml100k
./writepredictorforcofator.sh ml100k
./writerelevancevectorcofactor.sh ml100k one
./writerelevancevectorcofactor.sh ml100k five
./writerelevancevectorcofactor.sh ml100k ten

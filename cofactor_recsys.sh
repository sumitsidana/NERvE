cd ~/cofactor/src
LANG=en_US.utf8
echo "preprocessing"
python preprocess.py "/data/sidana/recnet_draft/recsys/cofactor"
echo "running cofactor"
python Cofactorization.py "/data/sidana/recnet_draft/recsys/cofactor/pro"
cd ~/nnmf_ranking/
./writegroundtruthforcofactor.sh recsys
./writepredictorforcofator.sh recsys
./writerelevancevectorcofactor.sh recsys one
./writerelevancevectorcofactor.sh recsys five
./writerelevancevectorcofactor.sh recsys ten

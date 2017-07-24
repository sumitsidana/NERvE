cd ~/cofactor/src
LANG=en_US.utf8
echo "preprocessing"
python preprocess.py "/data/sidana/recnet_draft/netflix/cofactor"
echo "running cofactor"
python Cofactorization.py "/data/sidana/recnet_draft/netflix/cofactor/pro"
cd ~/nnmf_ranking/
./writegroundtruthforcofactor.sh netflix
./writepredictorforcofator.sh netflix
./writerelevancevectorcofactor.sh netflix one
./writerelevancevectorcofactor.sh netflix five
./writerelevancevectorcofactor.sh netflix ten

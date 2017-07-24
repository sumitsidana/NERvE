cd ~/cofactor/src
LANG=en_US.utf8
echo "preprocessing"
python preprocess.py "/data/sidana/recnet_draft/cofactor/cofactor"
echo "running cofactor"
python Cofactorization.py "/data/sidana/recnet_draft/cofactor/cofactor/pro"
cd ~/nnmf_ranking/
./writegroundtruthforcofactor.sh cofactor
./writepredictorforcofator.sh cofactor
./writerelevancevectorcofactor.sh cofactor one
./writerelevancevectorcofactor.sh cofactor five
./writerelevancevectorcofactor.sh cofactor ten

cd ~/cofactor/src
LANG=en_US.utf8
echo "preprocessing"
python preprocess.py "/data/sidana/recnet_draft/kasandr/cofactor"
echo "running cofactor"
python Cofactorization.py "/data/sidana/recnet_draft/kasandr/cofactor/pro"
cd ~/nnmf_ranking/
./writegroundtruthforcofactor.sh kasandr
./writepredictorforcofator.sh kasandr
./writerelevancevectorcofactor.sh kasandr one
./writerelevancevectorcofactor.sh kasandr ten
./writerelevancevectorcofactor.sh kasandr ten

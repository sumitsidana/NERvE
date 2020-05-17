cd ~/cofactor/src
LANG=en_US.utf8
echo "preprocessing"
python preprocess.py "/data/sidana/recnet_draft/outbrain/cofactor"
echo "running cofactor"
python Cofactorization.py "/data/sidana/recnet_draft/outbrain/cofactor/pro"
cd ~/nnmf_ranking/
./writegroundtruthforcofactor.sh outbrain
./writepredictorforcofator.sh outbrain
./writerelevancevectorcofactor.sh outbrain one
./writerelevancevectorcofactor.sh outbrain five
./writerelevancevectorcofactor.sh outbrain ten

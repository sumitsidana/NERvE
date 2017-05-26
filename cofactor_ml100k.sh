cd ~/cofactor/src
LANG=en_US.utf8
echo "preprocessing"
python preprocess_outbrain.py "/data/sidana/recnet_draft/ml100k/cofactor"
echo "running cofactor"
python Cofactorization_outbrain.py "/data/sidana/recnet_draft/ml100k/cofactor/pro"
./writegroundtruthforcofactor.sh ml100k
./writepredictorforcofator.sh ml100k
./writerelevancevectorcofactor.sh ml100k one
./writerelevancevectorcofactor.sh ml100k five
./writerelevancevectorcofactor.sh ml100k ten

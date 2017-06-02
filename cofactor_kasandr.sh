cd ~/cofactor/src
LANG=en_US.utf8
echo "preprocessing"
python preprocess_outbrain.py "/data/sidana/recnet_draft/kasandr/cofactor"
echo "running cofactor"
python Cofactorization_outbrain.py "/data/sidana/recnet_draft/kasandr/cofactor/pro"
./writegroundtruthforcofactor.sh kasandr
./writepredictorforcofator.sh kasandr
./writerelevancevectorcofactor.sh kasandr one
./writerelevancevectorcofactor.sh kasandr five
./writerelevancevectorcofactor.sh kasandr ten

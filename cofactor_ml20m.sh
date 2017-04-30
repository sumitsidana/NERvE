cd ~/cofactor/src
LANG=en_US.utf8
echo "running for length: $i"
echo "preprocessing"
python preprocess_ml20m.py "/data/sidana/nnmf_ranking/archive_version/ml20m/cofactor"
python Cofactorization_ml20m.py "/data/sidana/nnmf_ranking/archive_version/ml20m/cofactor/pro"
cd -
./writegroundtruthforcofactor.sh
./writepredictorforcofator.sh
./writerelevancevectorcofactor.sh

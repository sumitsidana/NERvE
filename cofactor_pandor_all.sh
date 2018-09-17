cd ~/cofactor/src
LANG=en_US.utf8
echo "preprocessing"
python preprocess.py "/data/sidana/recnet_draft/pandor/cofactor_all"
echo "running cofactor"
python Cofactorization.py "/data/sidana/recnet_draft/pandor/cofactor_all/pro"
cd ~/nnmf_ranking/
./writegroundtruthforcofactor.sh pandor
./writepredictorforcofator.sh pandor
./writerelevancevectorcofactor.sh pandor one
./writerelevancevectorcofactor.sh pandor five
./writerelevancevectorcofactor.sh pandor ten

# For all items
# python Cofactorization.py /data/sidana/recnet_draft/kasandr/cofactor_all/pro/ and keep changing "k" in Cofactorization.py

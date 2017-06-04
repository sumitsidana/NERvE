cd ~/cofactor/src
LANG=en_US.utf8
echo "preprocessing"
python preprocess.py "/data/sidana/recnet_draft/kasandr/atleast_ten_o_two_c_v2/cofactor"
echo "running cofactor"
python Cofactorization.py "/data/sidana/recnet_draft/kasandr/atleast_ten_o_two_c_v2/cofactor/pro"
cd ~/nnmf_ranking/
./writegroundtruthforcofactor.sh kasandr/atleast_ten_o_two_c_v2
./writepredictorforcofator.sh kasandr/atleast_ten_o_two_c_v2
./writerelevancevectorcofactor.sh kasandr/atleast_ten_o_two_c_v2 one
./writerelevancevectorcofactor.sh kasandr/atleast_ten_o_two_c_v2 ten
./writerelevancevectorcofactor.sh kasandr/atleast_ten_o_two_c_v2 ten

cd ~/cofactor/src
LANG=en_US.utf8
echo "preprocessing"
python preprocess.py "/data/sidana/recnet_draft/kasandr/atleast_five_o_two_c/cofactor"
echo "running cofactor"
python Cofactorization.py "/data/sidana/recnet_draft/kasandr/atleast_five_o_two_c/cofactor/pro"
cd ~/nnmf_ranking/
./writegroundtruthforcofactor.sh kasandr/atleast_five_o_two_c
./writepredictorforcofator.sh kasandr/atleast_five_o_two_c
./writerelevancevectorcofactor.sh kasandr/atleast_five_o_two_c one
./writerelevancevectorcofactor.sh kasandr/atleast_five_o_two_c five
./writerelevancevectorcofactor.sh kasandr/atleast_five_o_two_c ten

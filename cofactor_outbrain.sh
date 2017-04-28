cd ~/cofactor/src
LANG=en_US.utf8
echo "running for length: $i"
echo "preprocessing"
python preprocess_outbrain.py "/data/sidana/nnmf_ranking/archive_version/outbrain/cofactor"
python Cofactorization_outbrain.py "/data/sidana/nnmf_ranking/archive_version/outbrain/cofactor/pro"

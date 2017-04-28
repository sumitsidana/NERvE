cd ~/cofactor/src
LANG=en_US.utf8
echo "running for length: $i"
echo "preprocessing"
python preprocess_ML1M.py "/data/sidana/nnmf_ranking/archive_version/outbrain"
python Cofactorization_outbrain.py "/data/sidana/nnmf_ranking/archive_version/outbrain/cofactor/pro"

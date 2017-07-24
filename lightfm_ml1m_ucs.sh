mkdir -p /data/sidana/recnet_draft/cold_start/ucs/ml1m/lightfm_all/vectors/
sed -i '1d' /data/sidana/recnet_draft/cold_start/ucs/ml1m/lightfm_all/train_all_raw.csv
sed -i '1d' /data/sidana/recnet_draft/cold_start/ucs/ml1m/lightfm_all/test_all_raw.csv
python3 lightfm_all_module_ucs.py ml1m ","
directoryofvectors='/data/sidana/recnet_draft/cold_start/ucs/ml1m/lightfm_all/vectors/'
cd $directoryofvectors
echo 'removing duplicates'
cat gt | uniq > gt_ml1m
cat pr | uniq > pr_ml1m
cd -
./writerelevancevectorlightfm_all_ucs.sh ml1m one
./writerelevancevectorlightfm_all_ucs.sh ml1m five
./writerelevancevectorlightfm_all_ucs.sh ml1m ten

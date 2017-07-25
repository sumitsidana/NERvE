mkdir -p /data/sidana/recnet_draft/cold_start/ucs/ml100k/lightfm_all/vectors/
sed -i '1d' /data/sidana/recnet_draft/cold_start/ucs/ml100k/lightfm_all/train_all_raw.csv
sed -i '1d' /data/sidana/recnet_draft/cold_start/ucs/ml100k/lightfm_all/test_all_raw.csv
python3 lightfm_all_module_ucs.py ml100k ","
directoryofvectors='/data/sidana/recnet_draft/cold_start/ucs/ml100k/lightfm_all/vectors/'
cd $directoryofvectors
echo 'removing duplicates'
cat gt | uniq > gt_ml100k
cat pr | uniq > pr_ml100k
cd -
./writerelevancevectorlightfm_all_ucs.sh ml100k one
./writerelevancevectorlightfm_all_ucs.sh ml100k five
./writerelevancevectorlightfm_all_ucs.sh ml100k ten

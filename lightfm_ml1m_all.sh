mkdir -p /data/sidana/recnet_draft/ml1m/lightfm_all/vectors/
cp /data/sidana/recnet_draft/ml1m/cofactor/pro/*raw* /data/sidana/recnet_draft/ml1m/lightfm_all/
sed -i '1d' /data/sidana/recnet_draft/ml1m/lightfm_all/train_all_raw.csv
sed -i '1d' /data/sidana/recnet_draft/ml1m/lightfm_all/test_all_raw.csv
python3 lightfm_all_module.py ml1m ","
directoryofvectors='/data/sidana/recnet_draft/ml1m/lightfm_all/vectors/'
cd $directoryofvectors
echo 'removing duplicates'
cat gt | uniq > gt_ml1m
cat pr | uniq > pr_ml1m
cd -
./writerelevancevectorlightfm_all.sh ml1m one
./writerelevancevectorlightfm_all.sh ml1m five
./writerelevancevectorlightfm_all.sh ml1m ten

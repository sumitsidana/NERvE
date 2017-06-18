mkdir -p /data/sidana/recnet_draft/ml1m/lightfm/vectors/
cp /data/sidana/recnet_draft/ml1m/cofactor/pro/*raw* /data/sidana/recnet_draft/ml1m/lightfm/
sed -i ‘1d' /data/sidana/recnet_draft/ml1m/lightfm/train_all_raw.csv 
sed -i ‘1d' /data/sidana/recnet_draft/ml1m/lightfm/test_all_raw.csv 
python3 lightfm_module.py ml1m ","
directoryofvectors='/data/sidana/recnet_draft/ml1m/lightfm/vectors/'
cd $directoryofvectors
echo 'removing duplicates'
cat gt | uniq > gt_ml1m
cat pr | uniq > pr_ml1m
cd -
./writerelevancevectorlightfm.sh ml1m one
./writerelevancevectorlightfm.sh ml1m five
./writerelevancevectorlightfm.sh ml1m ten

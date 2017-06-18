mkdir -p /data/sidana/recnet_draft/ml1m/lightfm/vectors/
cp /data/sidana/recnet_draft/ml1m/cofactor/pro/*raw* /data/sidana/recnet_draft/ml1m/lightfm/
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

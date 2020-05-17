mkdir -p /data/sidana/recnet_draft/ml100k/lightfm_all/vectors/
python3 lightfm_all_module.py ml100k ","
directoryofvectors='/data/sidana/recnet_draft/ml100k/lightfm_all/vectors/'
cd $directoryofvectors
echo 'removing duplicates'
cat gt | uniq > gt_ml100k
cat pr | uniq > pr_ml100k
cd -
./writerelevancevectorlightfm_all.sh ml100k one
./writerelevancevectorlightfm_all.sh ml100k five
./writerelevancevectorlightfm_all.sh ml100k ten
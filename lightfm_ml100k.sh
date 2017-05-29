mkdir -p /data/sidana/recnet_draft/ml100k/lightfm/vectors/
python3 lightfm.py ml100k ","
directoryofvectors='/data/sidana/recnet_draft/ml100k/lightfm/vectors/'
cd $directoryofvectors
echo 'removing duplicates'
cat gt | uniq > gt_ml100k
cat pr | uniq > pr_ml100k
cd -
./writerelevancevectorlightfm.sh ml100k one
./writerelevancevectorlightfm.sh ml100k five
./writerelevancevectorlightfm.sh ml100k ten

mkdir -p /data/sidana/recnet_draft/kasandr/lightfm/vectors/
python3 lightfm_module.py kasandr ","
directoryofvectors='/data/sidana/recnet_draft/kasandr/lightfm/vectors/'
cd $directoryofvectors
echo 'removing duplicates'
cat gt | uniq > gt_kasandr
cat pr | uniq > pr_kasandr
cd -
./writerelevancevectorlightfm.sh kasandr one
./writerelevancevectorlightfm.sh kasandr five
./writerelevancevectorlightfm.sh kasandr ten

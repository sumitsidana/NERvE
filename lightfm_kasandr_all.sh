mkdir -p /data/sidana/recnet_draft/kasandr/lightfm_all/vectors/
python3 lightfm_module_all.py kasandr ","
directoryofvectors='/data/sidana/recnet_draft/kasandr/lightfm_all/vectors/'
cd $directoryofvectors
echo 'removing duplicates'
cat gt | uniq > gt_kasandr
cat pr | uniq > pr_kasandr
cd -
./writerelevancevectorlightfm.sh kasandr one
./writerelevancevectorlightfm.sh kasandr five
./writerelevancevectorlightfm.sh kasandr ten

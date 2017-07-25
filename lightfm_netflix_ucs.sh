mkdir -p /data/sidana/recnet_draft/cold_start/ucs/netflix/lightfm_all/vectors/
sed -i '1d' /data/sidana/recnet_draft/cold_start/ucs/netflix/lightfm_all/train_all_raw.csv
sed -i '1d' /data/sidana/recnet_draft/cold_start/ucs/netflix/lightfm_all/test_all_raw.csv
python3 lightfm_all_module_ucs.py netflix ","
directoryofvectors='/data/sidana/recnet_draft/cold_start/ucs/netflix/lightfm_all/vectors/'
cd $directoryofvectors
echo 'removing duplicates'
cat gt | uniq > gt_netflix
cat pr | uniq > pr_netflix
cd -
./writerelevancevectorlightfm_all_ucs.sh netflix one
./writerelevancevectorlightfm_all_ucs.sh netflix five
./writerelevancevectorlightfm_all_ucs.sh netflix ten

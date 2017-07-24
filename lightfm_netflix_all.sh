mkdir -p /data/sidana/recnet_draft/netflix/lightfm_all/vectors/
cp /data/sidana/recnet_draft/netflix/cofactor/pro/*raw* /data/sidana/recnet_draft/netflix/lightfm_all/
sed -i '1d' /data/sidana/recnet_draft/netflix/lightfm_all/train_all_raw.csv
sed -i '1d' /data/sidana/recnet_draft/netflix/lightfm_all/test_all_raw.csv
python3 lightfm_all_module.py netflix ","
directoryofvectors='/data/sidana/recnet_draft/netflix/lightfm_all/vectors/'
cd $directoryofvectors
echo 'removing duplicates'
cat gt | uniq > gt_netflix
cat pr | uniq > pr_netflix
cd -
./writerelevancevectorlightfm_all.sh netflix one
./writerelevancevectorlightfm_all.sh netflix five
./writerelevancevectorlightfm_all.sh netflix ten

mkdir -p /data/sidana/recnet_draft/netflix/lightfm/vectors/
cp /data/sidana/recnet_draft/netflix/cofactor/pro/*raw* /data/sidana/recnet_draft/netflix/lightfm/
sed -i '1d' /data/sidana/recnet_draft/netflix/lightfm/train_all_raw.csv 
sed -i '1d' /data/sidana/recnet_draft/netflix/lightfm/test_all_raw.csv 
python3 lightfm_module.py netflix ","
directoryofvectors='/data/sidana/recnet_draft/netflix/lightfm/vectors/'
cd $directoryofvectors
echo 'removing duplicates'
cat gt | uniq > gt_netflix
cat pr | uniq > pr_netflix
cd -
./writerelevancevectorlightfm.sh netflix one
./writerelevancevectorlightfm.sh netflix five
./writerelevancevectorlightfm.sh netflix ten

#!/usr/bin/env bash
mkdir -p /data/sidana/recnet_draft/kasandr/lightfm_all/vectors/
python3 lightfm_module_all.py kasandr ","
directoryofvectors='/data/sidana/recnet_draft/kasandr/lightfm_all/vectors/'
cd $directoryofvectors
echo 'removing duplicates'
cat gt | uniq > gt_kasandr
cat pr | uniq > pr_kasandr
cd -
./writerelevancevectorlightfm_all.sh kasandr one
./writerelevancevectorlightfm_all.sh kasandr five
./writerelevancevectorlightfm_all.sh kasandr ten

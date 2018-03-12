LANG=en_US.utf8

mkdir -p /data/sidana/recnet/all_test_param_tune/$1/recnet_all/9/$3/rv/
javac  ConvertIntoRelVecGeneralized_update.java
if [ $3 == "one" ]
then
   rank=2
elif [ $3 == "five" ]
then
   rank=5
else
   rank=10
fi
java -cp . ConvertIntoRelVecGeneralized_update /data/sidana/recnet/all_test_param_tune/$1/recnet_all/9/vectors/gt_$1_$2 /data/sidana/recnet/all_test_param_tune/$1/recnet_all/9/vectors/pr_$1_$2 /data/sidana/recnet/all_test_param_tune/$1/recnet_all/9/$3/rv/relevanceVector_$1_$2 $rank

python3 compOfflineEvalMetrics_len${rank}_param_tune.py /data/sidana/recnet/all_test_param_tune/$1/recnet_all/9/$3 "$1_$2"

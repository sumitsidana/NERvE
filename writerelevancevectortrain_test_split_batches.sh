LANG=en_US.utf8
cd java/
mkdir -p /data/sidana/recnet/$1/recnet_batches/$3/rv/
javac -cp binaries/commons-lang3-3.5.jar  preProcess/ConvertIntoRelVecGeneralized_update.java preProcess/InputOutput.java
if [ $3 == "one" ]
then
   rank=2
elif [ $3 == "five" ]
then
   rank=5
else
   rank=10
fi
java -cp . preProcess.ConvertIntoRelVecGeneralized_update /data/sidana/recnet/$1/recnet_batches/vectors/gt_$1_$2 /data/sidana/recnet/$1/recnet_batches/vectors/pr_$1_$2 /data/sidana/recnet/$1/recnet_batches/$3/rv/relevanceVector_$1_$2 $rank
cd - >> uselessfile
python3 compOfflineEvalMetrics_len${rank}_batches.py /data/sidana/recnet/$1/recnet_batches/$3 "$1_$2"

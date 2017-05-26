LANG=en_US.utf8
cd java/
mkdir -p /data/sidana/recnet_draft/$1/recnet/$2/rv/
mkdir -p /data/sidana/recnet_draft/$1/recnet/$2/em/
javac -cp binaries/commons-lang3-3.5.jar  preProcess/ConvertIntoRelVecGeneralized_update.java preProcess/InputOutput.java
echo 'making relevance vector'
if [ $3 == "one" ]
then
   rank=2
elif [ $3 == "five" ]
then
   rank=5
else
   rank=10
fi
java -cp . preProcess.ConvertIntoRelVecGeneralized_update /data/sidana/recnet_draft/$1/recnet/vectors/gt_$1_$2 /data/sidana/recnet_draft/$1/recnet/vectors/pr_$1_$2 /data/sidana/recnet_draft/$1/recnet/$2/rv/relevanceVector_$1_$2 $3
cd -
echo 'compute offline metrics'
python3 compOfflineEvalMetrics_len5.py /data/sidana/recnet_draft/$1/recnet/$2 "$1_$2"

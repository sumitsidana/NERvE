LANG=en_US.utf8
cd java/
mkdir -p /data/sidana/recnet_draft/$1/cofactor/$2/rv/
mkdir -p /data/sidana/recnet_draft/$1/cofactor/$2/em/
javac -cp binaries/commons-lang3-3.5.jar  preProcess/ConvertIntoRelVecGeneralized_update.java preProcess/InputOutput.java
echo 'making relevance vector'

if [ $2 == "one" ]
then
   rank=2
elif [ $2 -gt "five" ]
then
   rank=5
else
   rank=10
fi

java -cp . preProcess.ConvertIntoRelVecGeneralized_update /data/sidana/recnet_draft/$1/cofactor/vectors/gt_$1 /data/sidana/recnet_draft/$1/cofactor/vectors/pr_$1 /data/sidana/recnet_draft/$1/cofactor/$2/rv/relevanceVector_$1 $rank
cd -
echo 'compute offline metrics'
python3 compOfflineEvalMetrics_len$rank.py /data/sidana/recnet_draft/$1/cofactor/$2 $1

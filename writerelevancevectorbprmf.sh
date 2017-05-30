LANG=en_US.utf8
cd java/
mkdir -p /data/recnet_draft/$1/bprmf/$2/rv/
mkdir -p /data/recnet_draft/$1/bprmf/$2/em/
javac -cp binaries/commons-lang3-3.5.jar  preProcess/ConvertIntoRelVecGeneralized_update.java preProcess/InputOutput.java
echo 'making relevance vector'

if [ $2 == "one" ]
then
   rank=2
elif [ $2 == "five" ]
then
   rank=5
else
   rank=10
fi

java -cp . preProcess.ConvertIntoRelVecGeneralized_update /data/recnet_draft/$1/bprmf/vectors/gt_$1 /data/recnet_draft/$1/bprmf/vectors/pr_$1 /data/recnet_draft/$1/bprmf/$2/rv/relevanceVector_$1 $rank
cd -
echo 'compute offline metrics'
python3 compOfflineEvalMetrics_len$rank.py /data/recnet_draft/$1/bprmf/$2 $1

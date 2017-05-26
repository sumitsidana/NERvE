LANG=en_US.utf8
cd java/
mkdir -p /data/sidana/recnet_draft/$1/recnet/five/rv/
mkdir -p /data/sidana/recnet_draft/$1/recnet/five/em/
javac -cp binaries/commons-lang3-3.5.jar  preProcess/ConvertIntoRelVecGeneralized_update.java preProcess/InputOutput.java
echo 'making relevance vector'
java -cp . preProcess.ConvertIntoRelVecGeneralized_update /data/sidana/recnet_draft/$1/recnet/vectors/gt_$1_$2 /data/sidana/recnet_draft/$1/recnet/vectors/pr_$1_$2 /data/sidana/recnet_draft/$1/recnet/five/rv/relevanceVector_$1_$2 5
cd -
echo 'compute offline metrics'
python3 compOfflineEvalMetrics_len5.py /data/sidana/recnet_draft/$1/recnet/five "$1_$2"

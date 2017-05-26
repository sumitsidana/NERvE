LANG=en_US.utf8
cd java/
mkdir -p /data/sidana/recnet_draft/$1/recnet/ten/rv/
mkdir -p /data/sidana/recnet_draft/$1/recnet/ten/em/
javac -cp binaries/commons-lang3-3.5.jar  preProcess/ConvertIntoRelVecGeneralized_update.java preProcess/InputOutput.java
echo 'making relevance vector'
java -cp . preProcess.ConvertIntoRelVecGeneralized_update /data/sidana/recnet_draft/$1/recnet/vectors/gt_$1_$2 /data/sidana/recnet_draft/$1/recnet/vectors/pr_$1_$2 /data/sidana/recnet_draft/$1/recnet/ten/rv/relevanceVector_$1_$2 10
cd -
echo 'compute offline metrics'
python3 compOfflineEvalMetrics_len10.py /data/sidana/recnet_draft/$1/recnet/ten "$1_$2"

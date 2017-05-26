LANG=en_US.utf8
cd java/
mkdir -p /data/sidana/recnet_draft/$1/cofactor/one/rv/
mkdir -p /data/sidana/recnet_draft/$1/cofactor/one/em/
javac -cp binaries/commons-lang3-3.5.jar  preProcess/ConvertIntoRelVecGeneralized_update.java preProcess/InputOutput.java
echo 'making relevance vector'
java -cp . preProcess.ConvertIntoRelVecGeneralized_update /data/sidana/recnet_draft/$1/cofactor/vectors/gt_$1 /data/sidana/recnet_draft/$1/cofactor/vectors/pr_$1 /data/sidana/recnet_draft/$1/cofactor/one/rv/relevanceVector_$1 1
cd -
echo 'compute offline metrics'
python3 compOfflineEvalMetrics_len3.py /data/sidana/recnet_draft/$1/cofactor/one $1

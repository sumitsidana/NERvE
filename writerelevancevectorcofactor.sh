LANG=en_US.utf8
cd java/
mkdir -p /data/sidana/recnet_draft/$1/cofactor/ten/rv/
mkdir -p /data/sidana/recnet_draft/$1/cofactor/ten/em/
javac -cp binaries/commons-lang3-3.5.jar  preProcess/ConvertIntoRelVecGeneralized_update.java preProcess/InputOutput.java
echo 'making relevance vector'
java -cp . preProcess.ConvertIntoRelVecGeneralized_update /data/sidana/recnet_draft/$1/cofactor/vectors/gt_$1 /data/sidana/recnet_draft/$1/cofactor/vectors/pr_$1 /data/sidana/recnet_draft/$1/cofactor/ten/rv/relevanceVector_$1 10
cd -
echo 'compute offline metrics'
python3 compOfflineEvalMetrics_len2.py /data/sidana/recnet_draft/$1/cofactor/ten $1

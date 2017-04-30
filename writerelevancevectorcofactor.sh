LANG=en_US.utf8
cd java/
mkdir -p /data/sidana/nnmf_ranking/archive_version/ml20m/cofactor/rv/
mkdir -p /data/sidana/nnmf_ranking/archive_version/ml20m/cofactor/em/
javac -cp binaries/commons-lang3-3.5.jar  preProcess/ConvertIntoRelVecGeneralized_update.java preProcess/InputOutput.java
echo 'making relevance vector'
java -cp . preProcess.ConvertIntoRelVecGeneralized_update /data/sidana/nnmf_ranking/archive_version/ml20m/cofactor/vectors/gt_ml20m /data/sidana/nnmf_ranking/archive_version/ml20m/cofactor/vectors/pr_ml20m /data/sidana/nnmf_ranking/archive_version/ml20m/cofactor/rv/relevanceVector_ml20m 10
cd -
echo 'compute offline metrics'
python3 compOfflineEvalMetrics_len2.py /data/sidana/nnmf_ranking/archive_version/ml20m/cofactor/ ml20m

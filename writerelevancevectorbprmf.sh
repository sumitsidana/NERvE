LANG=en_US.utf8
cd java/
mkdir -p /data/sidana/nnmf_ranking/archive_version/ml20m/bprmf/rv/
mkdir -p /data/sidana/nnmf_ranking/archive_version/ml20m/bprmf/em/
javac -cp binaries/commons-lang3-3.5.jar  preProcess/ConvertIntoRelVecGeneralized_update.java preProcess/InputOutput.java
echo 'making relevance vector'
java -cp . preProcess.ConvertIntoRelVecGeneralized_update /data/sidana/nnmf_ranking/archive_version/ml20m/bprmf/vectors/gt_ml20m /data/sidana/nnmf_ranking/archive_version/ml20m/bprmf/vectors/pr_ml20m /data/sidana/nnmf_ranking/archive_version/ml20m/bprmf/rv/relevanceVector_ml20m 10
cd -
echo 'compute offline metrics'
python3 compOfflineEvalMetrics_len2.py /data/sidana/nnmf_ranking/archive_version/ml20m/bprmf/ ml20m

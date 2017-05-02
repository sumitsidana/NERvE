LANG=en_US.utf8
cd java/
mkdir -p /data/sidana/nnmf_ranking/archive_version/outbrain/bprmf/five/rv/
mkdir -p /data/sidana/nnmf_ranking/archive_version/outbrain/bprmf/five/em/
javac -cp binaries/commons-lang3-3.5.jar  preProcess/ConvertIntoRelVecGeneralized_update.java preProcess/InputOutput.java
echo 'making relevance vector'
java -cp . preProcess.ConvertIntoRelVecGeneralized_update /data/sidana/nnmf_ranking/archive_version/outbrain/bprmf/vectors/gt_outbrain /data/sidana/nnmf_ranking/archive_version/outbrain/bprmf/vectors/pr_outbrain /data/sidana/nnmf_ranking/archive_version/outbrain/bprmf/rv/relevanceVector_outbrain 10
cd -
echo 'compute offline metrics'
python3 compOfflineEvalMetrics_len2.py /data/sidana/nnmf_ranking/archive_version/outbrain/bprmf/ outbrain

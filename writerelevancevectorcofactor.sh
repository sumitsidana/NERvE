LANG=en_US.utf8
cd java/src
echo 'making relevance vector'
javac -cp ../binaries/commons-lang3-3.5.jar  preProcess/ConvertIntoRelVecGeneralized_update.java preProcess/InputOutput.java
java -cp . preProcess.ConvertIntoRelVecGeneralized_update /data/sidana/nnmf_ranking/archive_version/outbrain/vectors/gt_outbrain /data/sidana/nnmf_ranking/archive_version/outbrain/vectors/pr_outbrain /data/sidana/nnmf_ranking/archive_version/outbrain/rv/relevanceVector_outbrain 10
cd -
echo 'compute offline metrics'
python3 compOfflineEvalMetrics_len3.py /data/sidana/nnmf_ranking/archive_version/outbrain/ outbrain

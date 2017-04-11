LANG=en_US.utf8
cd java/
javac -cp binaries/commons-lang3-3.5.jar  preProcess/ConvertIntoRelVecGeneralized_update.java preProcess/InputOutput.java
echo 'making relevance vector'
java -cp . preProcess.ConvertIntoRelVecGeneralized_update /data/sidana/nnmf_ranking/archive_version/outbrain/cofactor/vectors/gt_outbrain /data/sidana/nnmf_ranking/archive_version/outbrain/cofactor/vectors/pr_outbrain /data/sidana/nnmf_ranking/archive_version/outbrain/cofactor/five/rv/relevanceVector_outbrain 6
cd -
echo 'compute offline metrics'
python3 compOfflineEvalMetrics_len4.py /data/sidana/nnmf_ranking/archive_version/outbrain/cofactor/five outbrain

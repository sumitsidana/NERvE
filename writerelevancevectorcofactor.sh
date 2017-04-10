LANG=en_US.utf8
for i in "10" "20" "30" "50" "75" "100"
do
    cd java/src
    echo 'making relevance vector'
    javac -cp ../binaries/commons-lang3-3.5.jar  preProcess/ConvertIntoRelVecGeneralized_update.java preProcess/InputOutput.java
    java -cp . preProcess.ConvertIntoRelVecGeneralized_update /data/sidana/adaptivity/baseline_algorithms/cofactor/outbrain/len$i/vectors/gt_outbrain /data/sidana/adaptivity/baseline_algorithms/cofactor/outbrain/len$i/vectors/pr_outbrain /data/sidana/adaptivity/baseline_algorithms/cofactor/outbrain/len$i/one/rv/relevanceVector_outbrain 2
    cd -
    echo 'compute offline metrics'
    python3 compOfflineEvalMetrics_len3.py /data/sidana/adaptivity/baseline_algorithms/cofactor/outbrain/len$i/one/ outbrain
done

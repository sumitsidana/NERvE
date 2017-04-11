javac -cp ~/embAdaptivity/java/binaries/commons-lang3-3.5.jar  ~/embAdaptivity/java/src/preProcess/InputOutput.java ~/embAdaptivity/java/src/preProcess/WritePredictorForCofactor.java
LANG=en_US.utf8
echo "running for length: $i"
echo "preprocessing"
java -cp ~/embAdaptivity/java/src/ preProcess.WritePredictorForCofactor "/data/sidana/nnmf_ranking/archive_version/outbrain/cofactor/pro/test_all.csv" "/data/sidana/nnmf_ranking/archive_version/outbrain/cofactor/pro/pr" "/data/sidana/nnmf_ranking/archive_version/outbrain/cofactor/vectors/pr_outbrain"

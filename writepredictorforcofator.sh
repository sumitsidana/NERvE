javac -cp ~/embAdaptivity/java/binaries/commons-lang3-3.5.jar  ~/embAdaptivity/java/src/preProcess/InputOutput.java ~/embAdaptivity/java/src/preProcess/WritePredictorForCofactor.java
LANG=en_US.utf8
mkdir -p  /data/sidana/nnmf_ranking/archive_version/outbrain/vectors
echo "running for length: $i"
echo "preprocessing"
java -cp ~/embAdaptivity/java/src/ preProcess.WritePredictorForCofactor "/data/sidana/nnmf_ranking/archive_version/outbrain/pro/test_all.csv" "/data/sidana/nnmf_ranking/archive_version/outbrain/pro/pr" "/data/sidana/nnmf_ranking/archive_version/outbrain/vectors/pr_outbrain"

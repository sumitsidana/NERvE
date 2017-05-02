javac -cp ~/nnmf_ranking/java/binaries/commons-lang3-3.5.jar  ~/nnmf_ranking/java/preProcess/InputOutput.java ~/nnmf_ranking/java/preProcess/WritePredictorForBPRMF.java
LANG=en_US.utf8
mkdir -p  /data/sidana/nnmf_ranking/archive_version/ml20m/bprmf/vectors
echo "running for length: $i"
echo "preprocessing"
java -cp ~/nnmf_ranking/java/ preProcess.WritePredictorForBPRMF "/data/sidana/nnmf_ranking/archive_version/ml20m/bprmf/test.bprmf" "/data/sidana/nnmf_ranking/archive_version/ml20m/bprmf/prediction_file" "/data/sidana/nnmf_ranking/archive_version/ml20m/bprmf/vectors/pr_ml20m"

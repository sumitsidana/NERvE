javac -cp ~/nnmf_ranking/nnmf_ranking/java/binaries/commons-lang3-3.5.jar  ~/nnmf_ranking/nnmf_ranking/java/preProcess/InputOutput.java ~/nnmf_ranking/nnmf_ranking/java/preProcess/WritePredictorForBPRMF.java
LANG=en_US.utf8
mkdir -p  /data/recnet_draft/$1/bprmf/vectors
echo "running for length: $i"
echo "preprocessing"
java -cp ~/nnmf_ranking/nnmf_ranking/java/ preProcess.WritePredictorForBPRMF "/data/recnet_draft/$1/bprmf/test.inputbprmf" "/data/recnet_draft/$1/bprmf/prediction_file" "/data/recnet_draft/$1/bprmf/vectors/pr_$1"

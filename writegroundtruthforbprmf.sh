javac -cp ~/nnmf_ranking/java/binaries/commons-lang3-3.5.jar  ~/nnmf_ranking/java/preProcess/InputOutput.java ~/nnmf_ranking/java/preProcess/WriteGroundTruthForBPRMF.java
LANG=en_US.utf8
mkdir -p  /data/sidana/nnmf_ranking/archive_version/outbrain/bprmf/vectors
echo "running for length: $i"
echo "preprocessing"
java -cp ~/nnmf_ranking/java/ preProcess.WriteGroundTruthForBPRMF  "/data/sidana/nnmf_ranking/archive_version/outbrain/bprmf/test.bprmf" "/data/sidana/nnmf_ranking/archive_version/outbrain/bprmf/vectors/gt_outbrain"

javac -cp ~/nnmf_ranking/java/binaries/commons-lang3-3.5.jar  ~/nnmf_ranking/java/src/preProcess/InputOutput.java ~/nnmf_ranking/java/src/preProcess/WriteGroundTruthForbprmf.java
LANG=en_US.utf8
mkdir -p  /data/sidana/nnmf_ranking/archive_version/outbrain/bprmf/vectors
echo "running for length: $i"
echo "preprocessing"
java -cp ~/embAdaptivity/java/src/ preProcess.WriteGroundTruthForbprmf  "/data/sidana/nnmf_ranking/archive_version/outbrain/bprmf/pro/test.csv" "/data/sidana/nnmf_ranking/archive_version/outbrain/bprmf/vectors/gt_outbrain"

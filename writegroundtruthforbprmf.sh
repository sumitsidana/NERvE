javac -cp ~/nnmf_ranking/java/binaries/commons-lang3-3.5.jar  ~/nnmf_ranking/java/preProcess/InputOutput.java ~/nnmf_ranking/java/preProcess/WriteGroundTruthForBPRMF.java
LANG=en_US.utf8
mkdir -p  /data/sidana/recnet_draft/$1/bprmf/vectors
java -cp ~/nnmf_ranking/java/ preProcess.WriteGroundTruthForBPRMF  "/data/sidana/recnet_draft/$1/bprmf/test.bprmf" "/data/sidana/recnet_draft/$1/bprmf/vectors/gt_ml20m"

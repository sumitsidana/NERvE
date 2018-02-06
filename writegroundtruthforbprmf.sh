mkdir -p  /data/sidana/recnet/$1/bprmf/vectors
java -cp ./java/ preProcess.WriteGroundTruthForBPRMF  "/data/sidana/recnet/$1/bprmf/test.inputbprmf" "/data/sidana/recnet/$1/bprmf/vectors/gt_$1"

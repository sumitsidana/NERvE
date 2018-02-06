LANG=en_US.utf8
mkdir -p  /data/sidana/recnet/$1/bprmf/vectors
java -cp ./java/ preProcess.WritePredictorForBPRMF "/data/sidana/recnet/$1/bprmf/test.inputbprmf" "/data/sidana/recnet/$1/bprmf/prediction_file" "/data/sidana/recnet/$1/bprmf/vectors/pr_$1"

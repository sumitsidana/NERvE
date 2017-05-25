javac -cp ~/embAdaptivity/java/binaries/commons-lang3-3.5.jar  ~/embAdaptivity/java/src/preProcess/InputOutput.java ~/embAdaptivity/java/src/preProcess/WriteGroundTruthForCofactor.java
LANG=en_US.utf8
mkdir -p "/data/sidana/recnet_draft/$1/cofactor/vectors"
echo "running for length: $i"
echo "preprocessing"
java -cp ~/embAdaptivity/java/src/ preProcess.WriteGroundTruthForCofactor  "/data/sidana/recnet_draft/$1/cofactor/pro/test.csv" "/data/sidana/recnet_draft/$1/cofactor/vectors/gt_ml20m"

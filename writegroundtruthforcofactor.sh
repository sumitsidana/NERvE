javac -cp ~/embAdaptivity/java/binaries/commons-lang3-3.5.jar  ~/embAdaptivity/java/src/preProcess/InputOutput.java ~/embAdaptivity/java/src/preProcess/WriteGroundTruthForCofactor.java
LANG=en_US.utf8
mkdir -p "/data/sidana/recnet_draft/$1/cofactor/vectors"
echo "writing ground truth for cofactor"
temp=$1
var=${temp/\//_}
java -cp ~/embAdaptivity/java/src/ preProcess.WriteGroundTruthForCofactor  "/data/sidana/recnet_draft/$1/cofactor/pro/test.csv" "/data/sidana/recnet_draft/$1/cofactor/vectors/gt_$var”
echo "done"

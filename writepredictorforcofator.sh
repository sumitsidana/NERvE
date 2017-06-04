javac -cp ~/embAdaptivity/java/binaries/commons-lang3-3.5.jar  ~/embAdaptivity/java/src/preProcess/InputOutput.java ~/embAdaptivity/java/src/preProcess/WritePredictorForCofactor.java
LANG=en_US.utf8
temp=$1
var=${temp/\//_}
java -cp ~/embAdaptivity/java/src/ preProcess.WritePredictorForCofactor "/data/sidana/recnet_draft/$1/cofactor/pro/test_all.csv" "/data/sidana/recnet_draft/$1/cofactor/pro/pr" "/data/sidana/recnet_draft/$1/cofactor/vectors/pr_$var"

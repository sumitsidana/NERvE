sed -i.bak 1i"[userid_clicks,offerid_clicks,userid_offers,offerid_offers]" /data/sidana/nnmf_ranking/rschallenge2016/totalData.csv
header=`echo -e "userid\tofferid\trating"`
javac /home/ama/sidana/recsysBaselines/code/java/preProcess/RemoveBrackets.java /home/ama/sidana/recsysBaselines/code/java/preProcess/InputOutput.java /home/ama/sidana/recsysBaselines/code/java/preProcess/CreateDelimiterSeperatedInput.java
java -cp /home/ama/sidana/recsysBaselines/code/java preProcess.RemoveBrackets /data/sidana/nnmf_ranking/rschallenge2016/totalData.csv /data/sidana/nnmf_ranking/rschallenge2016/totalDataRanking.csv
java -cp /home/ama/sidana/recsysBaselines/code/java preProcess.CreateDelimiterSeperatedInput /data/sidana/nnmf_ranking/rschallenge2016/totalDataRanking.csv /data/sidana/nnmf_ranking/rschallenge2016/recsys.challenge.input "$header"

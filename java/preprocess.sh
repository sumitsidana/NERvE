sed -i.bak 1i"[userid_clicks,offerid_clicks,userid_offers,offerid_offers]" totalData.csv
header=`echo -e "userid\tofferid\trating"`
javac /home/ama/sidana/nnmf_ranking/java/preProcess/RemoveBrackets.java /home/ama/sidana/nnmf_ranking/java/preProcess/InputOutput.java /home/ama/sidana/nnmf_ranking/java/preProcess/CreateDelimiterSeperatedInput.java
java -cp /home/ama/sidana/nnmf_ranking/java preProcess.RemoveBrackets /data/sidana/nnmf_ranking/recsys2016_click/totalData.csv /data/sidana/nnmf_ranking/recsys2016_click/totalDataRanking.csv
java -cp /home/ama/sidana/nnmf_ranking/java preProcess.CreateDelimiterSeperatedInput /data/sidana/nnmf_ranking/recsys2016_click/totalDataRanking.csv /data/sidana/nnmf_ranking/recsys2016_click/recsys.challenge.input "$header"

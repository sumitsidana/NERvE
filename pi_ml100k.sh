# recnet_draft: user_past_preferences
#sudo java -cp java/ preProcess.GroupInteractionByUserItem /data/user_past_preference.csv /data/userInteractions.csv
#java -cp ./java/ preProcess.TargetUsersPastInteractions /data/sidana/recnet_draft/ml100k/pi/userInteractions.csv /data/sidana/recnet_draft/ml100k/pi/test.users /data/sidana/recnet_draft/ml100k/pi/vectors/pr_ml100k

bash ./writerelevancevectorbprmf.sh ml100k one
bash ./writerelevancevectorbprmf.sh ml100k five
bash ./writerelevancevectorbprmf.sh ml100k ten


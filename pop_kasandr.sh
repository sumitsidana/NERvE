
./spark-submit --class main.scala.popularity_kasandr --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar
# recnet_draft: Popularity
# :yy 1,749p
#paste -d' ' test.users mostpopularitems.txt > vectors/pr_ml100k
bash ./writerelevancevectorpop.sh ml100k one
bash ./writerelevancevectorpop.sh ml100k five
bash ./writerelevancevectorpop.sh ml100k ten

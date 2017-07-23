cd ~/recnet_draft/scala/
sbt package
cd ~/../spark/spark/bin/

echo "writing all users"
./spark-submit --class "main.scala.write_old_users_ml1m"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing all items"
./spark-submit --class "main.scala.write_old_items_ml1m"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

cd /data/sidana/recnet_draft/cold_start/data/ml1m

echo "renaming all users file"
mv dat.ml1m.users/part-00000 .
rm -rf dat.ml1m.users
mv part-00000 dat.ml1m.users

echo "renaming all items file"
mv dat.ml1m.items/part-00000 .
rm -rf dat.ml1m.items
mv part-00000 dat.ml1m.items

echo "taking random sample of users and items and writing them to old files"
sed -i '1d' dat.ml1m.users
sed -i '1d' dat.ml1m.items

num_users="`wc -l dat.ml1m.users|awk '{print $1}'`"
num_items="`wc -l dat.ml1m.items|awk '{print $1}'`"
num_sample_users="$(($num_users/2))"
num_sample_items="$(($num_items/2))"
shuf -n $num_sample_users dat.ml1m.users > dat.ml1m.users.old
shuf -n $num_sample_items dat.ml1m.items > dat.ml1m.items.old

echo "adding headers"
sed -i 1i"userId" dat.ml1m.users.old
sed -i 1i"movieId" dat.ml1m.items.old

echo "writing new users  file"
cd ~/../spark/spark/bin/
./spark-submit --class "main.scala.write_new_users_ml1m"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing new items file"
./spark-submit --class "main.scala.write_new_items_ml1m"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "renaming new users and items file and adding headers"
cd /data/sidana/recnet_draft/cold_start/data/ml1m
mv dat.ml1m.users.new/part-00000 .
rm -rf dat.ml1m.users.new
mv part-00000 dat.ml1m.users.new
mv dat.ml1m.items.new/part-00000 .
rm -rf dat.ml1m.items.new
mv part-00000 dat.ml1m.items.new

sed -i 1i"userId" dat.ml1m.users.new
sed -i 1i"movieId" dat.ml1m.items.new

cd ~/../spark/spark/bin/

echo "writing old users old items file"
./spark-submit --class "main.scala.write_data_old_u_old_i_ml_1m"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing new users old items file"

./spark-submit --class "main.scala.write_data_new_u_old_i_ml_1m"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing old users new items file"

./spark-submit --class "main.scala.write_data_old_u_new_i_ml_1m"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing new users new items file"

./spark-submit --class "main.scala.write_data_new_u_new_i_ml_1m"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

cd /data/sidana/recnet_draft/cold_start/data/ml1m

mv dat.ml1m.oldusersolditems/part-00000 .
rm -rf dat.ml1m.oldusersolditems
mv part-00000 dat.ml1m.oldusersolditems

mv dat.ml1m.newusersolditems/part-00000 .
rm -rf dat.ml1m.newusersolditems
mv part-00000 dat.ml1m.newusersolditems

mv dat.ml1m.oldusersnewitems/part-00000 .
rm -rf dat.ml1m.oldusersnewitems
mv part-00000 dat.ml1m.oldusersnewitems 

mv dat.ml1m.newusersnewitems/part-00000 .
rm -rf dat.ml1m.newusersnewitems
mv part-00000 dat.ml1m.newusersnewitems




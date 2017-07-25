cd ~/recnet_draft/scala/
sbt package
cd ~/../spark/spark/bin/

echo "writing all users"
./spark-submit --class "main.scala.write_old_users_netflix"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing all items"
./spark-submit --class "main.scala.write_old_items_netflix"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

cd /data/sidana/recnet_draft/cold_start/data/netflix

echo "renaming all users file"
mv dat.netflix.users/part-00000 .
rm -rf dat.netflix.users
mv part-00000 dat.netflix.users

echo "renaming all items file"
mv dat.netflix.items/part-00000 .
rm -rf dat.netflix.items
mv part-00000 dat.netflix.items

echo "taking random sample of users and items and writing them to old files"
sed -i '1d' dat.netflix.users
sed -i '1d' dat.netflix.items

num_users="`wc -l dat.netflix.users|awk '{print $1}'`"
num_items="`wc -l dat.netflix.items|awk '{print $1}'`"
num_sample_users="$(($num_users/2))"
num_sample_items="$(($num_items/2))"
shuf -n $num_sample_users dat.netflix.users > dat.netflix.users.old
shuf -n $num_sample_items dat.netflix.items > dat.netflix.items.old

echo "adding headers"
sed -i 1i"userId" dat.netflix.users.old
sed -i 1i"movieId" dat.netflix.items.old

echo "writing new users  file"
cd ~/../spark/spark/bin/
./spark-submit --class "main.scala.write_new_users_netflix"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing new items file"
./spark-submit --class "main.scala.write_new_items_netflix"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "renaming new users and items file and adding headers"
cd /data/sidana/recnet_draft/cold_start/data/netflix
mv dat.netflix.users.new/part-00000 .
rm -rf dat.netflix.users.new
mv part-00000 dat.netflix.users.new
mv dat.netflix.items.new/part-00000 .
rm -rf dat.netflix.items.new
mv part-00000 dat.netflix.items.new

sed -i 1i"userId" dat.netflix.users.new
sed -i 1i"movieId" dat.netflix.items.new

cd ~/../spark/spark/bin/

echo "writing old users old items file"
./spark-submit --class "main.scala.write_data_old_u_old_i_netflix"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing new users old items file"

./spark-submit --class "main.scala.write_data_new_u_old_i_netflix"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing old users new items file"

./spark-submit --class "main.scala.write_data_old_u_new_i_netflix"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing new users new items file"

./spark-submit --class "main.scala.write_data_new_u_new_i_netflix"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

cd /data/sidana/recnet_draft/cold_start/data/netflix

mv dat.netflix.oldusersolditems/part-00000 .
rm -rf dat.netflix.oldusersolditems
mv part-00000 dat.netflix.oldusersolditems

mv dat.netflix.newusersolditems/part-00000 .
rm -rf dat.netflix.newusersolditems
mv part-00000 dat.netflix.newusersolditems

mv dat.netflix.oldusersnewitems/part-00000 .
rm -rf dat.netflix.oldusersnewitems
mv part-00000 dat.netflix.oldusersnewitems 

mv dat.netflix.newusersnewitems/part-00000 .
rm -rf dat.netflix.newusersnewitems
mv part-00000 dat.netflix.newusersnewitems


cp dat.netflix.oldusersolditems ../../ucs/netflix/recnet_all/train_all_raw.csv
cp dat.netflix.oldusersolditems ../../ics/netflix/recnet_all/train_all_raw.csv
cp dat.netflix.oldusersolditems ../../ics/netflix/recnet_all/train_all_raw.csv

cp dat.netflix.newusersolditems ../../ucs/netflix/recnet_all/test_all_raw.csv
cp dat.netflix.oldusersnewitems ../../ics/netflix/recnet_all/test_all_raw.csv
cp dat.netflix.newusersnewitems ../../uics/netflix/recnet_all/test_all_raw.csv

cd ~/recnet_draft

python3 cart_prod_form_cold_start.py netflix ucs

python3 cart_prod_form_cold_start.py netflix ics

python3 cart_prod_form_cold_start.py netflix uics

./recnet_netflix_all_cold_start_ucs.sh

./recnet_netflix_all_cold_start_ics.sh

./recnet_netflix_all_cold_start_uics.sh
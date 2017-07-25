cd ~/recnet_draft/scala/
sbt package
cd ~/../spark/spark/bin/

echo "writing all users"
./spark-submit --class "main.scala.write_old_users_ml100k"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 25 --executor-memory 10G --driver-memory 10G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing all items"
./spark-submit --class "main.scala.write_old_items_ml100k"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 25 --executor-memory 10G --driver-memory 10G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

cd /data/sidana/recnet_draft/cold_start/data/ml100k

echo "renaming all users file"
mv dat.ml100k.users/part-00000 .
rm -rf dat.ml100k.users
mv part-00000 dat.ml100k.users

echo "renaming all items file"
mv dat.ml100k.items/part-00000 .
rm -rf dat.ml100k.items
mv part-00000 dat.ml100k.items

echo "taking random sample of users and items and writing them to old files"
sed -i '1d' dat.ml100k.users
sed -i '1d' dat.ml100k.items

num_users="`wc -l dat.ml100k.users|awk '{print $1}'`"
num_items="`wc -l dat.ml100k.items|awk '{print $1}'`"
num_sample_users="$(($num_users/2))"
num_sample_items="$(($num_items/2))"
shuf -n $num_sample_users dat.ml100k.users > dat.ml100k.users.old
shuf -n $num_sample_items dat.ml100k.items > dat.ml100k.items.old

echo "adding headers"
sed -i 1i"userId" dat.ml100k.users.old
sed -i 1i"movieId" dat.ml100k.items.old

echo "writing new users  file"
cd ~/../spark/spark/bin/
./spark-submit --class "main.scala.write_new_users_ml100k"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 25 --executor-memory 10G --driver-memory 10G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing new items file"
./spark-submit --class "main.scala.write_new_items_ml100k"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 25 --executor-memory 10G --driver-memory 10G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "renaming new users and items file and adding headers"
cd /data/sidana/recnet_draft/cold_start/data/ml100k
mv dat.ml100k.users.new/part-00000 .
rm -rf dat.ml100k.users.new
mv part-00000 dat.ml100k.users.new
mv dat.ml100k.items.new/part-00000 .
rm -rf dat.ml100k.items.new
mv part-00000 dat.ml100k.items.new

sed -i 1i"userId" dat.ml100k.users.new
sed -i 1i"movieId" dat.ml100k.items.new

cd ~/../spark/spark/bin/

echo "writing old users old items file"
./spark-submit --class "main.scala.write_data_old_u_old_i_ml100k"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 25 --executor-memory 10G --driver-memory 10G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing new users old items file"

./spark-submit --class "main.scala.write_data_new_u_old_i_ml100k"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 25 --executor-memory 10G --driver-memory 10G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing old users new items file"

./spark-submit --class "main.scala.write_data_old_u_new_i_ml100k"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 25 --executor-memory 10G --driver-memory 10G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing new users new items file"

./spark-submit --class "main.scala.write_data_new_u_new_i_ml100k"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 25 --executor-memory 10G --driver-memory 10G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

cd /data/sidana/recnet_draft/cold_start/data/ml100k

mv dat.ml100k.oldusersolditems/part-00000 .
rm -rf dat.ml100k.oldusersolditems
mv part-00000 dat.ml100k.oldusersolditems

mv dat.ml100k.newusersolditems/part-00000 .
rm -rf dat.ml100k.newusersolditems
mv part-00000 dat.ml100k.newusersolditems

mv dat.ml100k.oldusersnewitems/part-00000 .
rm -rf dat.ml100k.oldusersnewitems
mv part-00000 dat.ml100k.oldusersnewitems 

mv dat.ml100k.newusersnewitems/part-00000 .
rm -rf dat.ml100k.newusersnewitems
mv part-00000 dat.ml100k.newusersnewitems


cp dat.ml100k.oldusersolditems ../../ucs/ml100k/recnet_all/train_all_raw.csv
cp dat.ml100k.oldusersolditems ../../ics/ml100k/recnet_all/train_all_raw.csv
cp dat.ml100k.oldusersolditems ../../ics/ml100k/recnet_all/train_all_raw.csv

cp dat.ml100k.newusersolditems ../../ucs/ml100k/recnet_all/test_all_raw.csv
cp dat.ml100k.oldusersnewitems ../../ics/ml100k/recnet_all/test_all_raw.csv
cp dat.ml100k.newusersnewitems ../../uics/ml100k/recnet_all/test_all_raw.csv

cd ~/recnet_draft

python3 cart_prod_form_cold_start.py ml100k ucs

python3 cart_prod_form_cold_start.py ml100k ics

python3 cart_prod_form_cold_start.py ml100k uics

./recnet_ml100k_all_cold_start_ucs.sh

#./recnet_ml100k_all_cold_start_ics.sh

#./recnet_ml100k_all_cold_start_uics.sh
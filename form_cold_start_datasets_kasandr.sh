cd ~/recnet_draft/scala/
sbt package
cd ~/../spark/spark/bin/

echo "writing all users"
./spark-submit --class "main.scala.write_old_users_kasandr"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing all items"
./spark-submit --class "main.scala.write_old_items_kasandr"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

cd /data/sidana/recnet_draft/cold_start/data/kasandr

echo "renaming all users file"
mv dat.kasandr.users/part-00000 .
rm -rf dat.kasandr.users
mv part-00000 dat.kasandr.users

echo "renaming all items file"
mv dat.kasandr.items/part-00000 .
rm -rf dat.kasandr.items
mv part-00000 dat.kasandr.items

echo "taking random sample of users and items and writing them to old files"
sed -i '1d' dat.kasandr.users
sed -i '1d' dat.kasandr.items

num_users="`wc -l dat.kasandr.users|awk '{print $1}'`"
num_items="`wc -l dat.kasandr.items|awk '{print $1}'`"
num_sample_users="$(($num_users/2))"
num_sample_items="$(($num_items/2))"
shuf -n $num_sample_users dat.kasandr.users > dat.kasandr.users.old
shuf -n $num_sample_items dat.kasandr.items > dat.kasandr.items.old

echo "adding headers"
sed -i 1i"userId" dat.kasandr.users.old
sed -i 1i"movieId" dat.kasandr.items.old

echo "writing new users  file"
cd ~/../spark/spark/bin/
./spark-submit --class "main.scala.write_new_users_kasandr"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing new items file"
./spark-submit --class "main.scala.write_new_items_kasandr"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "renaming new users and items file and adding headers"
cd /data/sidana/recnet_draft/cold_start/data/kasandr
mv dat.kasandr.users.new/part-00000 .
rm -rf dat.kasandr.users.new
mv part-00000 dat.kasandr.users.new
mv dat.kasandr.items.new/part-00000 .
rm -rf dat.kasandr.items.new
mv part-00000 dat.kasandr.items.new

sed -i 1i"userId" dat.kasandr.users.new
sed -i 1i"movieId" dat.kasandr.items.new

cd ~/../spark/spark/bin/

echo "writing old users old items file"
./spark-submit --class "main.scala.write_data_old_u_old_i_kasandr"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing new users old items file"

./spark-submit --class "main.scala.write_data_new_u_old_i_kasandr"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing old users new items file"

./spark-submit --class "main.scala.write_data_old_u_new_i_kasandr"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

echo "writing new users new items file"

./spark-submit --class "main.scala.write_data_new_u_new_i_kasandr"  --packages com.databricks:spark-csv_2.11:1.4.0 --total-executor-cores 50 --executor-memory 20G --driver-memory 20G --conf spark.driver.maxResultSize=5G  ~/recnet_draft/scala/target/scala-2.11/simple-project_2.11-1.0.jar

cd /data/sidana/recnet_draft/cold_start/data/kasandr

mv dat.kasandr.oldusersolditems/part-00000 .
rm -rf dat.kasandr.oldusersolditems
mv part-00000 dat.kasandr.oldusersolditems

mv dat.kasandr.newusersolditems/part-00000 .
rm -rf dat.kasandr.newusersolditems
mv part-00000 dat.kasandr.newusersolditems

mv dat.kasandr.oldusersnewitems/part-00000 .
rm -rf dat.kasandr.oldusersnewitems
mv part-00000 dat.kasandr.oldusersnewitems 

mv dat.kasandr.newusersnewitems/part-00000 .
rm -rf dat.kasandr.newusersnewitems
mv part-00000 dat.kasandr.newusersnewitems


cp dat.kasandr.oldusersolditems ../../ucs/kasandr/recnet_all/train_all_raw.csv
cp dat.kasandr.oldusersolditems ../../ics/kasandr/recnet_all/train_all_raw.csv
cp dat.kasandr.oldusersolditems ../../ics/kasandr/recnet_all/train_all_raw.csv

cp dat.kasandr.newusersolditems ../../ucs/kasandr/recnet_all/test_all_raw.csv
cp dat.kasandr.oldusersnewitems ../../ics/kasandr/recnet_all/test_all_raw.csv
cp dat.kasandr.newusersnewitems ../../uics/kasandr/recnet_all/test_all_raw.csv

cd ~/recnet_draft

python3 cart_prod_form_cold_start.py kasandr ucs

python3 cart_prod_form_cold_start.py kasandr ics

python3 cart_prod_form_cold_start.py kasandr uics

./recnet_kasandr_all_cold_start_ucs.sh

#./recnet_kasandr_all_cold_start_ics.sh

#./recnet_kasandr_all_cold_start_uics.sh
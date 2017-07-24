package main.scala
import java.nio.file.{ Files, Paths }
import scala.collection.mutable.ListBuffer
import java.io.FileWriter
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf
import org.apache.spark.sql.SQLContext
import org.apache.spark.sql.functions._
import java.nio.file.{ Files, Paths }
import scala.collection.mutable.ListBuffer
import java.io.FileWriter



object write_data_new_u_new_i_ml_1m {
	def main(args: Array[String]) {
		val conf = new SparkConf().setAppName("Simple Application")
				val sc = new SparkContext(conf)
				val sqlContext = new SQLContext(sc)
				import sqlContext._
				import sqlContext.implicits._
val test = sqlContext.read
    .format("com.databricks.spark.csv")
    .option("header", "true") // Use first line of all files as header
    .option("inferSchema", "true") // Automatically infer data types
    .option("delimiter", ",")
    .load("/data/sidana/recnet_draft/cold_start/data/netflix/inputdata.headers")

val newUsers = sqlContext.read
    .format("com.databricks.spark.csv")
    .option("header", "true") // Use first line of all files as header
    .option("inferSchema", "true") // Automatically infer data types
    .option("delimiter", "\t")
    .load("/data/sidana/recnet_draft/cold_start/data/netflix/dat.netflix.users.new")

val newItems = sqlContext.read
    .format("com.databricks.spark.csv")
    .option("header", "true") // Use first line of all files as header
    .option("inferSchema", "true") // Automatically infer data types
    .option("delimiter", "\t")
    .load("/data/sidana/recnet_draft/cold_start/data/netflix/dat.netflix.items.new")


    
val trainUsers = test.join(newUsers,test("userId")===newUsers("userId")).drop(newUsers("userId"))
val trainUsersItemsTemp = trainUsers.join(newItems,trainUsers("movieId")===newItems("movieId")).drop(newItems("movieId")).select("userId","movieId","rating","timestamp")

val header = "userId,movieId,rating,timestamp"

val trainUsersItems = trainUsersItemsTemp.map(_.mkString(",")).mapPartitionsWithIndex((i, iter) => if (i==0) (List(header).toIterator ++ iter) else iter)
trainUsersItems.coalesce(1,false).saveAsTextFile("/data/sidana/recnet_draft/cold_start/data/netflix/dat.netflix.newusersnewitems")

	}
}

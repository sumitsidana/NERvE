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



object write_data_old_u_old_i_ml_1m {
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
    .load("/data/sidana/recnet_draft/cold_start/data/ml1m/inputdata.headers")

val oldUsers = sqlContext.read
    .format("com.databricks.spark.csv")
    .option("header", "true") // Use first line of all files as header
    .option("inferSchema", "true") // Automatically infer data types
    .option("delimiter", "\t")
    .load("/data/sidana/recnet_draft/cold_start/data/ml1m/dat.ml1m.users.old")

val oldItems = sqlContext.read
    .format("com.databricks.spark.csv")
    .option("header", "true") // Use first line of all files as header
    .option("inferSchema", "true") // Automatically infer data types
    .option("delimiter", "\t")
    .load("/data/sidana/recnet_draft/cold_start/data/ml1m/dat.ml1m.items.old")



    
val trainUsers = test.join(oldUsers,test("userId")===oldUsers("userId")).drop(oldUsers("userId"))
val trainUsersItems = trainUsers.join(oldItems,trainUsers("movieId")===oldItems("movieId")).drop(oldItems("movieId"))

val distinctUsersRating = trainUsersItems.select("userId","rating").distinct
val groupByUsers =  distinctUsersRating.groupBy("userId").count
val goodUsers  = groupByUsers.filter($"count">=2)

val filetobewrittentemp = trainUsersItems.join(goodUsers,trainUsersItems("userId")===goodUsers("userId")).drop(goodUsers("userId")).drop(goodUsers("count")).select("userId","movieId","rating","timestamp")

val header = "userId,movieId,rating,timestamp"

val filetobewritten =filetobewrittentemp.map(_.mkString(",")).mapPartitionsWithIndex((i, iter) => if (i==0) (List(header).toIterator ++ iter) else iter)

filetobewritten.coalesce(1,false).saveAsTextFile("/data/sidana/recnet_draft/cold_start/data/ml1m/dat.ml1m.oldusersolditems")
	}
}

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



object write_old_users_kasandr {
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
    .load("/data/sidana/recnet_draft/cold_start/data/kasandr/inputdata.headers")
val usersTemp = test.select("userId").distinct
val header = "userId"
val users=usersTemp.rdd.map(_.mkString(",")).mapPartitionsWithIndex((i, iter) => if (i==0) (List(header).toIterator ++ iter) else iter)
users.coalesce(1,false).saveAsTextFile("/data/sidana/recnet_draft/cold_start/data/kasandr/dat.kasandr.users")
	}
}

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



object write_old_items_ml1m {
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
    .option("delimiter", "\t")
    .load("/data/sidana/recnet_draft/cold_start/data/ml1m/inputdata.headers")
val itemsTemp = test.select("movieId").distinct
val header = "movieId"
val items = itemsTemp.rdd.map(_.mkString(",")).mapPartitionsWithIndex((i, iter) => if (i==0) (List(header).toIterator ++ iter) else iter)
items.coalesce(1,false).saveAsTextFile("/data/sidana/recnet_draft/cold_start/data/ml1m/dat.ml1m.items")
	}
}

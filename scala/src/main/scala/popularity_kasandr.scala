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



object popularity_kasandr {
	def main(args: Array[String]) {
		val conf = new SparkConf().setAppName("Simple Application")
				val sc = new SparkContext(conf)
				val sqlContext = new SQLContext(sc)
				import sqlContext._
				import sqlContext.implicits._
				val t1 = System.currentTimeMillis
				val csvFileClick = sqlContext.read
				.format("com.databricks.spark.csv")
				.option("header", "true") // Use first line of all files as header
				.option("inferSchema", "true") // Automatically infer data types
				.option("delimiter", ",")
				.load("/data/sidana/recnet_draft/kasandr/pop/train_all_raw.csv")

				val clickTemp = csvFileClick.filter(csvFileClick("rating") ==="4")

				val groupedByUsersandOffers = clickTemp.select(clickTemp("userId"),clickTemp("movieId")).distinct
				val groupedByOffers = groupedByUsersandOffers.groupBy("movieId").count.sort(desc("count"))
				val topItems = groupedByOffers.select("movieId").rdd.map(r => r(0)).take(100)

				val items = new ListBuffer[String]()
				val fw = new FileWriter("/data/sidana/recnet_draft/kasandr/pop/mostpopularitems.txt", true)
				for( a <- 1 to 100){
					val firstval = topItems(a-1)
							items += firstval.toString.toString
							fw.write(firstval.toString.toString+" ")
				}
		val t2 = System.currentTimeMillis
				println((t2 - t1) + " msecs")
				fw.close()


	}
}

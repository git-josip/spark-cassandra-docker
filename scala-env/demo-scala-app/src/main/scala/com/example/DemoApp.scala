package com.example

import org.apache.spark.{Logging, SparkContext, SparkConf}

trait DemoApp extends App with Logging {
  val sparkMasterHost = "spark://sparkmaster:7077"
  val cassandraHost = "cassandra"

  // Tell Spark the address of one Cassandra node:
  val conf = new SparkConf()
    .set("spark.cassandra.connection.host", cassandraHost)
    .set("spark.cleaner.ttl", "3600")
    .set("spark.local.ip", "172.17.0.6")
    .setMaster(sparkMasterHost)
    .setJars(Seq(SparkContext.jarOfClass(this.getClass).get))
    .setAppName(getClass.getSimpleName)

  // Connect to the Spark cluster:
  lazy val sc = new SparkContext(conf)
}

object DemoApp {
  def apply(): DemoApp = new DemoApp {}
}

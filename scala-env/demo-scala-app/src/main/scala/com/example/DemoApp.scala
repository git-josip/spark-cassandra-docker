package com.example

import java.net._
import org.apache.spark.{Logging, SparkContext, SparkConf}

trait DemoApp extends App with Logging {
  val sparkMasterHost = "spark://sparkmaster:7077"
  val cassandraHost = "cassandra"
  val hostIp = InetAddress.getLocalHost.getHostAddress

  // Tell Spark the address of one Cassandra node:
  val conf = new SparkConf()
    .set("spark.cassandra.connection.host", cassandraHost)
    .set("spark.cleaner.ttl", "3600")
    .set("spark.local.ip", hostIp)
    .setJars(Seq(SparkContext.jarOfClass(this.getClass).get))
    .setMaster(sparkMasterHost)
    .setAppName(getClass.getSimpleName)
    .setMaster(sparkMasterHost)

  // Connect to the Spark cluster:
  val sc = new SparkContext(conf)
  sc.setLogLevel("INFO")
}

object DemoApp {
  def apply(): DemoApp = new DemoApp {}
}

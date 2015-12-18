import com.typesafe.sbt.packager.docker.Cmd

name := """sbt-docker-example"""

version := "1.0"

scalaVersion := "2.11.7"

// Change this to another test framework if you prefer
libraryDependencies += "org.scalatest" %% "scalatest" % "2.2.4" % "test"

// Dependencies
libraryDependencies += "org.apache" %% "spark-assembly" % "1.5.2" from "https://s3.amazonaws.com/foxtrot-libs/spark-assembly-1.5.2_2.11.jar"

libraryDependencies += "com.datastax.spark" %% "spark-cassandra-connector" % "1.5.0-M3" from "http://repo1.maven.org/maven2/com/datastax/spark/spark-cassandra-connector_2.11/1.5.0-M3/spark-cassandra-connector_2.11-1.5.0-M3.jar"

enablePlugins(JavaAppPackaging)
enablePlugins(DockerPlugin)

dockerBaseImage := "frolvlad/alpine-oraclejdk8"

dockerCommands := dockerCommands.value.flatMap{
  case cmd@Cmd("FROM",_) => List(cmd,Cmd("RUN", "apk update && apk add bash"))
  case other => List(other)
}
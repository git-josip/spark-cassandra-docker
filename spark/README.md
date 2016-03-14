This container uses Spark compiled for Scala 2.11

Instruction to build:
1. Download the [source](http://spark.apache.org/downloads.html)
2. Extract the tarball somewhere convenient and navigate to the directory
3. `export JAVA_HOME=$(/usr/libexec/java_home)`. Ensure that the variable is pointing to Java 8
4. `./dev/change-scala-version.sh 2.11`
5. `./build/sbt -Pyarn -Phadoop-2.6 -Dhadoop.version=2.6.4 -Dscala-2.11 -Phive -Phive-thriftserver -DskipTests "project spark" assembly`
6. `cd assembly/target/scala-2.11`
7. Upload the assembly jar to s3 foxtrot-libs bucket
8. Go back to root. Open `./project/SparkBuild.scala` and add `assemblyOption in assembly ~= { _.copy(includeScala = false) }` to settings.
Example:
```
    lazy val settings = assemblySettings ++ Seq(
        test in assembly := {},
        hadoopVersion := {
          sys.props.get("hadoop.version")
            .getOrElse(SbtPomKeys.effectivePom.value.getProperties.get("hadoop.version").asInstanceOf[String])
        },
        jarName in assembly <<= (version, moduleName, hadoopVersion) map { (v, mName, hv) =>
          if (mName.contains("streaming-flume-assembly") || mName.contains("streaming-kafka-assembly") || mName.contains("streaming-mqtt-assembly") || mName.contains("streaming-kinesis-asl-assembly")) {
            // This must match the same name used in maven (see external/kafka-assembly/pom.xml)
            s"${mName}-${v}.jar"
          } else {
            s"${mName}-${v}-hadoop${hv}.jar"
          }
        },
        jarName in (Test, assembly) <<= (version, moduleName, hadoopVersion) map { (v, mName, hv) =>
          s"${mName}-test-${v}.jar"
        },
        mergeStrategy in assembly := {
          case PathList("org", "datanucleus", xs @ _*)             => MergeStrategy.discard
          case m if m.toLowerCase.endsWith("manifest.mf")          => MergeStrategy.discard
          case m if m.toLowerCase.matches("meta-inf.*\\.sf$")      => MergeStrategy.discard
          case "log4j.properties"                                  => MergeStrategy.discard
          case m if m.toLowerCase.startsWith("meta-inf/services/") => MergeStrategy.filterDistinctLines
          case "reference.conf"                                    => MergeStrategy.concat
          case _                                                   => MergeStrategy.first
        },
        deployDatanucleusJars := {
          val jars: Seq[File] = (fullClasspath in assembly).value.map(_.data)
            .filter(_.getPath.contains("org.datanucleus"))
          var libManagedJars = new File(BuildCommons.sparkHome, "lib_managed/jars")
          libManagedJars.mkdirs()
          jars.foreach { jar =>
            val dest = new File(libManagedJars, jar.getName)
            if (!dest.exists()) {
              Files.copy(jar.toPath, dest.toPath)
            }
          }
        },
        assembly <<= assembly.dependsOn(deployDatanucleusJars),
        assemblyOption in assembly ~= { _.copy(includeScala = false) }
      )
```
9. `./build/sbt -Pyarn -Phadoop-2.6 -Dhadoop.version=2.6.4 -Dscala-2.11 -Phive -Phive-thriftserver -DskipTests "project spark" assembly`
10. `cd assembly/target/scala-2.11`
11. Rename the assembly jar and append `-without-scala` to the name. e.g. `spark-assembly-1.6.1-hadoop2.6.4-without-scala.jar`
12. Upload this jar to s3.
13. `./make-distribution.sh --tgz -Pyarn -Phadoop-2.6 -Dhadoop.version=2.6.4 -Dscala-2.11 -Phive -Phive-thriftserver -DskipTests`
14. There should be a tarball that looks like `spark-${VERSION}-bin-2.6.4.tgz`
15. Copy it to a temporary location and extract it with `tar -xvzf spark-${VERSION}-bin-2.6.4.tgz`
16. `cd spark-${VERSION}-bin-2.6.4/lib`
17. `rm spark-examples-${VERSION}-hadoop2.6.4.jar`
18. `cd ../../`
19. `tar -cvzf spark-${VERSION}-bin-2.6.4-scala-2.11-jdk8.tgz spark-${VERSION}-bin-2.6.4`
20. Upload the tarball to s3
21. Update the Dockerfile to reference the new tarball
22. Update all other application Dockerfile that require spark to reference the new `spark-assembly-${VERSION}-hadoop2.6.4-without-scala.jar`




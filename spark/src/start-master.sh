#!/usr/bin/env bash

if [ -z "$SPARK_MASTER_HOST" ]; then echo "SPARK_MASTER_HOST is unset. Quitting" && exit 1; fi

$JAVA_HOME/bin/java -cp $SPARK_HOME/sbin/../conf/:$SPARK_HOME/lib/spark-assembly-1.5.2-hadoop2.7.1.jar \
	-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 \
	-Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 \
	-Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 \
	-Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory -Xms1g \
	-Xmx1g org.apache.spark.deploy.master.Master --host $SPARK_MASTER_HOST --port 7077 --webui-port 8080 \
	--properties-file /spark-defaults.conf
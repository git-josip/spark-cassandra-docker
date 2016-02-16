#!/usr/bin/env bash

export SPARK_CLASSPATH="${SPARK_HOME}/sbin/../conf/:${SPARK_HOME}/lib/*"

${JAVA_HOME}/bin/java -cp ${SPARK_CLASSPATH} \
	-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 \
	-Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 \
	-Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 \
	-Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory \
	-Dspark.worker.cleanup.appDataTtl=86400 -Dspark.worker.cleanup.interval=1800 \
	-Xms1g -Xmx1g org.apache.spark.deploy.worker.Worker spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT} \
	--webui-port 8081 --properties-file /spark-defaults.conf --work-dir ${SPARK_WORK_DIR} \
	-i ${SPARK_LOCAL_IP} --port 8888 
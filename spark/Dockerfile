FROM foxtrotsystems/centos7:jdk8

# Spark install
RUN mkdir /usr/local/spark-1.6.0-bin-2.7.1-scala-2.11-jdk-8
RUN curl -s https://s3.amazonaws.com/foxtrot-libs/spark-1.6.0-bin-2.7.1-scala-2.11-jdk-8.tar.gz | tar -xz -C /usr/local/spark-1.6.0-bin-2.7.1-scala-2.11-jdk-8
RUN cd /usr/local && ln -s spark-1.6.0-bin-2.7.1-scala-2.11-jdk-8 spark
ENV SPARK_HOME /usr/local/spark

# Spark utils/conf
ADD src/start-master.sh /start-master.sh
ADD src/start-worker.sh /start-worker.sh
ADD src/spark-defaults.conf /spark-defaults.conf
ADD src/log4j.properties $SPARK_HOME/conf/log4j.properties

# Spark Dependencies
ADD lib /usr/local/spark/lib

# Spark Configuration
ENV SPARK_MASTER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"
ENV SPARK_WORKER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"
ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_WORKER_PORT 8888
ENV SPARK_WORKER_WEBUI_PORT 8081

# Configure supervisord
ADD src/supervisord-master.conf /etc/supervisord-master.conf
ADD src/supervisord-worker.conf /etc/supervisord-worker.conf
RUN mkdir -p /var/log/supervisor

# Deploy startup script
ADD src/start.sh /usr/local/bin/start

EXPOSE 8080 7077 8888 8081 4040 7001 7002 7003 7004 7005 7006

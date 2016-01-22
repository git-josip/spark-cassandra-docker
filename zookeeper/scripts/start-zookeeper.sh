#!/usr/bin/env bash

echo ${ZK_ID} > /var/lib/zookeeper/myid

printf "tickTime=2000
dataDir=/var/lib/zookeeper/
clientPort=2181
initLimit=5
syncLimit=2
${ZK_ENSEMBLE/${SERVICE_NAME}.service.consul/0.0.0.0}
" > ${ZK_HOME}/conf/zoo.cfg

java -cp ${ZK_HOME}/zookeeper-${ZK_VERSION}.jar:${ZK_HOME}/lib/slf4j-api-1.6.1.jar:${ZK_HOME}/lib/slf4j-log4j12-1.6.1.jar:${ZK_HOME}/lib/log4j-1.2.16.jar:${ZK_HOME}/conf \
  org.apache.zookeeper.server.quorum.QuorumPeerMain ${ZK_HOME}/conf/zoo.cfg

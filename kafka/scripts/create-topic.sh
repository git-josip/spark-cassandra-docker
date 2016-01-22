#!/usr/bin/env bash

${KAFKA_HOME}/bin/kafka-topics.sh --create --zookeeper ${ZK_HOSTS} --replication-factor 3 "$@"

FROM foxtrotsystems/ubuntu-base:0.9.18

RUN apt-get update -y

ENV SCALA_VERSION 2.11
ENV KAFKA_VERSION 0.9.0.0
ENV KAFKA_HOME /opt/kafka_"${SCALA_VERSION}"-"${KAFKA_VERSION}"

RUN wget -q http://apache.mirrors.spacedump.net/kafka/"${KAFKA_VERSION}"/kafka_"${SCALA_VERSION}"-"${KAFKA_VERSION}".tgz -O /tmp/kafka_"${SCALA_VERSION}"-"${KAFKA_VERSION}".tgz
RUN tar -xzf /tmp/kafka_"${SCALA_VERSION}"-"${KAFKA_VERSION}".tgz -C /opt
RUN rm /tmp/kafka_"${SCALA_VERSION}"-"${KAFKA_VERSION}".tgz

VOLUME ["/var/lib/kafka"]

ADD conf/server.properties ${KAFKA_HOME}/config/server.properties
ADD conf/supervisord.conf /etc/supervisord.conf
ADD scripts/start-kafka.sh scripts/create-topic.sh /usr/local/bin/

EXPOSE 9092

CMD ["supervisord", "-n"]

#RUN apt-get install -y vim dnsutils
#RUN apt-get install -y xinetd telnetd telnet

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

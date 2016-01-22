FROM foxtrotsystems/ubuntu-base:0.9.18

ENV ZK_VERSION 3.4.6
ENV ZK_HOME /opt/zookeeper-"${ZK_VERSION}"

RUN apt-get update -y

RUN wget -q http://mirror.cogentco.com/pub/apache/zookeeper/zookeeper-"${ZK_VERSION}"/zookeeper-"${ZK_VERSION}".tar.gz -O /tmp/zookeeper-"${ZK_VERSION}".tgz
RUN tar -xzf /tmp/zookeeper-"${ZK_VERSION}".tgz -C /opt
RUN rm /tmp/zookeeper-"${ZK_VERSION}".tgz

VOLUME ["/var/lib/zookeeper"]

ADD conf/supervisord.conf /etc/supervisord.conf
ADD scripts/start-zookeeper.sh /usr/local/bin/

EXPOSE 2181 2888 3888

CMD ["supervisord", "-n"]

#RUN apt-get install -y dnsutils
#RUN apt-get install -y xinetd telnetd telnet

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

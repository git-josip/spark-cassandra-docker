FROM cassandra:2.1.12

# Install:
# supervisor: to run supervised commands
# curl: to install opscenter agents 
# sysstat: for opscenter monitoring
RUN apt-get update
RUN apt-get install -y supervisor curl sysstat

# Download OpsCenter Agent
RUN curl -L http://downloads.datastax.com/community/datastax-agent-5.2.2.tar.gz | tar xz -C /usr/local
RUN ln -s /usr/local/datastax-agent-5.2.2 /usr/local/datastax-agent

# Deploy startup script
ADD src/start.sh /usr/local/bin/start

# Configure supervisord
ADD src/supervisord.conf /etc/supervisord.conf

# Necessary since cassandra is trying to check for a NPE that freezes boot2docker
RUN sed -ri '/CASSANDRA-7254/,+5d' /usr/sbin/cassandra

EXPOSE 7199 7000 7001 9160 9042
EXPOSE 22 8012 61621
USER root
CMD start

FROM foxtrotsystems/centos7:jdk8

# Install ssh dependencies
RUN yum install -y openssh-clients

# Download OpsCenter
ENV OPSCENTER_HOME usr/local/opscenter
ENV OPSCENTER_PACKAGE opscenter-5.2.2
RUN curl -L http://downloads.datastax.com/community/$OPSCENTER_PACKAGE.tar.gz | tar -xz -C /usr/local
RUN ln -s /usr/local/$OPSCENTER_PACKAGE $OPSCENTER_HOME

# Configure supervisory
ADD src/supervisord.conf /etc/supervisord.conf

ADD src/start.sh /usr/local/bin/start

# See http://www.datastax.com/documentation/opscenter/4.0/opsc/reference/opscPorts_r.html
EXPOSE 8888 61620 50031
USER root 
CMD start 

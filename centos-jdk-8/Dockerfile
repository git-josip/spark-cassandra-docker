FROM centos:centos7

# Add source repositories
ADD src/epel7.repo /etc/yum.repos.d/epel7.repo
ADD src/datastax.repo /etc/yum.repos.d/datastax.repo

# Install basic packages and supervisord
RUN yum install -y wget curl tar supervisor sudo which hostname
RUN yum clean all

# Configure supervisord
RUN mkdir -p /var/log/supervisor

# Download Oracle Java 8u65
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u65-b17/jdk-8u65-linux-x64.rpm"
RUN yum localinstall -y jdk-8u65-linux-x64.rpm
RUN rm -rf jdk-8u65-linux-x64.rpm

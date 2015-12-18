FROM raimille1/spark-cassandra:centos-jdk-8

# Download and install scala
RUN curl -O http://downloads.typesafe.com/scala/2.11.7/scala-2.11.7.rpm
RUN rpm -ivh scala-2.11.7.rpm
RUN rm -rf scala-2.11.7.rpm
ENV SCALA_HOME /opt/scala

# Install sbt
RUN curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo
RUN yum install -y sbt git

USER root
CMD bash 

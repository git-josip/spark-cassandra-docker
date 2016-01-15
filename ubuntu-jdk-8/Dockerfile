FROM phusion/baseimage:0.9.18

ENV FOXTROT_USER foxtrot
ENV FOXTROT_HOME /home/foxtrot

RUN useradd --create-home --home ${FOXTROT_HOME} ${FOXTROT_USER}

# Install basic packages and supervisord
RUN apt-get update
RUN apt-get install -y python-setuptools sudo
RUN easy_install supervisor==3.2

# Configure supervisord
RUN mkdir -p /var/log/supervisor

# Download Oracle Java 8u65
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN apt-get install -y oracle-java8-installer


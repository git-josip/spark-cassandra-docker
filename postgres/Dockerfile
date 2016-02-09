FROM postgres:9.5.0

ENV PGROUTING_VERSION 2.1.0-1

COPY ./preferences /etc/apt/preferences
COPY ./unstable.list /etc/apt/sources.list.d/unstable.list

RUN apt-get update
RUN apt-get -t unstable install -y postgresql-9.5-pgrouting=${PGROUTING_VERSION}

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

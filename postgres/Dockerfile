FROM postgres:9.5.0

ENV POSTGIS_MAJOR 2.2
ENV POSTGIS_VERSION 2.2.1+dfsg-2.pgdg80+1
ENV PGROUTING_VERSION 2.0.0-5.pgdg80+1

RUN apt-get update
RUN apt-get install -y postgresql-9.5-postgis-${POSTGIS_MAJOR}=${POSTGIS_VERSION}
RUN apt-get install -y postgresql-9.5-pgrouting=${PGROUTING_VERSION}

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

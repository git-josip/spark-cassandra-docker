#!/usr/bin/env bash

# Refresh conf based on Env vars
./docker-entrypoint.sh 

# Start process
echo Starting Cassandra ...
/usr/bin/supervisord -c /etc/supervisord.conf

#!/usr/bin/env bash

# Refresh conf based on Env vars
./docker-entrypoint.sh 

# Start process
if [[ -z $OPSCENTER_HOST ]]; then
    echo Starting Cassandra without OpsCenter ...
	/usr/bin/supervisord -c /etc/supervisord-no-ops-center.conf
else
    sleep 15
    echo Starting Cassandra with OpsCenter in $OPSCENTER_HOST ...
    curl \
      http://$OPSCENTER_HOST:8888/cluster-configs \
      -X POST \
      -d \
      "{
          \"cassandra\": {
            \"seed_hosts\": \"$CASSANDRA_SEEDS\"
          },
          \"cassandra_metrics\": {},
          \"jmx\": {
            \"port\": \"7199\"
          }
      }" > /dev/null
    /usr/bin/supervisord -c /etc/supervisord.conf
fi
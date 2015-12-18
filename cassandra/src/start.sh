#!/usr/bin/env bash

IP=$(curl -s --connect-timeout 2 http://169.254.169.254/latest/meta-data/local-ipv4)

function validateIP()
{
    local ip=$1
    local stat=1
    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
        && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi

    return $stat
}

validateIP $IP
if [[ $? -ne 0 ]];then
  IP=$(hostname -i)
fi

export CASSANDRA_BROADCAST_ADDRESS=$IP
export CASSANDRA_SEEDS=$IP
# Refresh conf based on Env vars
./docker-entrypoint.sh 

# Start process
echo Starting Cassandra on $IP...
/usr/bin/supervisord -c /etc/supervisord.conf

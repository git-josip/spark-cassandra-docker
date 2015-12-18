#!/usr/bin/env bash

IP=`hostname --ip-address`

sed -i -e "s/^interface.*/interface = $IP/" $OPSCENTER_HOME/conf/opscenterd.conf

echo Starting OpsCenter on $IP...
/usr/bin/supervisord -c /etc/supervisord.conf
#!/usr/bin/env bash

if [ $1 = "master" ]; then
	/usr/bin/supervisord -c /etc/supervisord-master.conf
elif [ $1 = "worker" ]; then
	/usr/bin/supervisord -c /etc/supervisord-worker.conf
fi
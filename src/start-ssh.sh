#!/bin/bash
. genkeys.sh

ports=$(echo $REMOTE_PORTS | tr ";" "\n")
PARAM=""

for port in $ports
do
PARAM="$PARAM -L *:$port:localhost:$port"
done
echo $PARAM

autossh -M 0 \
 -g \
 -N \
 -o "StrictHostKeyChecking=no" \
 -o "ServerAliveInterval=30" \
 -o "ServerAliveCountMax=3" \
 -i ./keys/id_rsa \
 $PARAM $HOST


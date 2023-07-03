#!/bin/bash

if [[ -z $1 ]]; then
    echo "ERROR: Missing host parameter (user@host)"
    exit 1
fi

HOST=$1
PORT=43043

if [[ -n $2 ]]; then
    PORT=$2
fi

eval $(ssh-agent)
ssh-add ~/.ssh/id_rsa

 while true; do
    echo "try to connect..."
    ssh -N -o ServerAliveInterval=240 -R $PORT:localhost:22 $HOST
    echo "restarting in 5 seconds.."
    sleep 5
 done


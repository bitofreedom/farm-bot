#!/bin/bash

# Parameters:
# IP List (file path)
# remote host username

IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing
for i in $(cat < "$1"); do
  echo "Checking miner status on host: $i"
  HASH_RATE=$(ssh ethos@192.168.2.223 'show stats' | grep 'status:' | awk '{print $2}')
  echo $(($HASH_RATE))
  echo  $(($HASH_RATE <= 2000))
  if [[ $HASH_RATE -lt 2000 ]]
  then
    echo "TEST $i"
# ssh $2@$i 'sudo reboot'
  fi
done
echo "Script Ends..."

#!/bin/bash -x

# Parameters:
# IP List (file path)
# remote host username

IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing
for i in $(cat < "$1"); do
  echo "Starting miner on host: $i"
  ssh -oStrictHostKeyChecking=no $2@$i 'cd /home/ethos && clear-thermals && sleep 2 && allow'
done
echo "Script Ends..."

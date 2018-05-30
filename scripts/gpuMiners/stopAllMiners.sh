#!/bin/bash -x

# Parameters:
# IP List (file path)
# remote host username

IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing
for i in $(cat < "$1"); do
  echo "Stopping miner on host: $i"
  ssh $2@$i 'cd /home/ethos && disallow && sleep 2 && minestop'
done
echo "Script Ends..."

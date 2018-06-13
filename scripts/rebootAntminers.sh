#!/bin/bash -x

# Parameters:
# IP List (file path)
# remote host username

IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing
for i in $(cat < "$1"); do
  echo "Rebooting Host: $i"
  ssh $2@$i '/sbin/reboot'
done

echo "Script Ends..."

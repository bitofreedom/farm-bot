#!/bin/bash -x

# Parameters:
# IP List (file path)


IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing
for i in $(cat < "$1"); do
  echo "Sending .ssh/id_rsa.pub to Host: $i"
  ssh root@$i 'mkdir -p .ssh'
  cat .ssh/id_rsa.pub | ssh root@$i 'cat >> .ssh/authorized_keys'
  ssh root@$i 'chmod 700 .ssh; chmod 640 .ssh/authorized_keys'
done

echo "Script Ends..."

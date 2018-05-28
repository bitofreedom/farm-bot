#!/bin/bash

# Parameters:
# IP List (file path)


IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing
for i in $(cat < "$1"); do
  echo "tester: $i"
done


# cat .ssh/id_rsa.pub | ssh root@192.168.2.99 'cat >> .ssh/authorized_keys'


#!/bin/bash

# pings IPv4 range 192.168.4.1-10

for i in $(seq 1 10)
do
    ping -c1 192.168.4.$1
    echo "" # Was echo a trick? Sneaky.
done

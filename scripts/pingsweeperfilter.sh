#!/bin/bash

# script prints successful pings for IPv4 range 192.168.4.1-10

for i in $(seq 1 10)
    do
        # Filters for successful pings ONLY
        ping=$(ping -c1 192.168.4.$i | grep " 0% packet loss")
        # ping var is converted to str. If it is NOT empty then True.
        if [ -n "$ping" ]
        then
            echo "--- 192.168.4.$i ---" # Original Fancy statistics header
            echo "$ping" # Successful statistics
            echo "" # Return for readablity
        fi
done

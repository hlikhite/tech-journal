#!/bin/bash

# script pings a range of host ids from a network id
# $1= networkid $2= start hostid $3= end hostid

for i in $(seq $2 $3)
    do
    # Filters for successful pings ONLY
    ping=$(ping -c1 $1$i | grep " 0% packet loss")
    if [ -n "$ping" ] # if ping var converted to str is NOT empty then True
    then
        echo "--- $1$i ping statistics ---" # Original fancy statistics header
        echo "$ping" # Successful statistics
        echo ""
    fi
done

#!/bin/bash

# script pings IPv4 address range 10.0.5.1-10 to see if it is active. If active it prints an nslookup for the address

for i in $(seq 1 10)
    do
        # Filters for successful pings
        ping=$(ping -c1 10.0.5.$i | grep " 0% packet loss")
        if [ -n "$ping" ] # if ping var converted to str is NOT empty then True
        then
            # local domain resolution for active IP address in range
            nslookup 10.0.5.$i
        fi
done

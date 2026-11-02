#!/bin/bash

# function nmapinstall is a loop that ensures nmap is installed. if declined the script will end.
function nmapinstall {
    while true # loop starts
    do
        echo "nmap is not installed. Would you like to install nmap (y/n)"
        read answer
        if [ "$answer" = "y" ]
        then
            # Installs nmap and breaks loop
            sudo dnf install nmap
            break
        elif [ "$answer" = "n" ]
        then
            # nmap was declined and script ends
            echo "nmap is required for this process. exiting..."
            exit
        else
            # Unexpected output. Repeat loop.
            echo "error: invalid response. please enter y/n"
        fi
    done
}

# Verifies nmap is installed. If not, nmapinstall function is run.
nmap -v &> /dev/null || nmapinstall

# user input of network/cdir to scan
echo "What is the network (x.x.x.x/x)?"
read network

# user input of parameter(s) to run
echo "What are your parameters?"
read parameter

# scan executed
nmap $parameter $network

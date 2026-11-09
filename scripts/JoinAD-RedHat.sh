#!/bin/bash

# Joins Rocky Linux device to a domain

# NOTE: run as root

# Install required modules
dnf install -y realmd samba samba-common oddjob oddjob-mkhomedir sssd adcli || exit 1 # ends if fail

# User input domain and login
read -p "What domain would you like to join? " DOMAIN
read -p "ADM username: " ADMUSER

# joins realm
realm join --user="$ADMUSER@${DOMAIN^^}" "$DOMAIN"

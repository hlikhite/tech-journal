#!/bin/bash

# This script sets up a new device and joins it to an active directory
# NOTE: run as root

# error breaks script
set -e

# user input variables (could be changed to regular variables; this is just easier to follow during a lab)
read -p "HOSTNAME: " hostn
read -p "INTERFACE: " intface
read -p "IP/CDIR: " ipcdir
read -p "NEW ADMIN-LOC: " newuser
read -p "GATEWAY IP: " gateway
read -p "AD IP: " ad
read -p "DOMAIN: " local


# Set hostname
hostnamectl set-hostname $hostn

# add admin-loc account
id "$newuser" &>/dev/null || useradd "$newuser"
passwd "$newuser"
usermod -aG wheel "$newuser"

# set interface IP
conn=$(nmcli -g GENERAL.CONNECTION dev show "$intface")
nmcli con mod "$conn" ipv4.method manual ipv4.addresses "$ipcdir" ipv4.gateway "$gateway" ipv4.dns "$ad" ipv4.dns-search $local
ip addr del 10.0.5.157/24 dev "$intface" && sudo systemctl restart NetworkManager
nmcli con up "$conn"


# restrict ssh
sed -i 's/^PermitRootLogin yes/#&\nPermitRootLogin no/' /etc/ssh/sshd_config.d/01-permitrootlogin.conf && systemctl reload ssh





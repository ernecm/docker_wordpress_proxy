#!/bin/bash
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT ACCEPT

sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 7878 -j ACCEPT

sudo netfilter-persistent save

echo "Firewall rules applied. Only ports 22, 80, and 7878 are open."
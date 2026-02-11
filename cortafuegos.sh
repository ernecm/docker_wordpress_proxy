#!/bin/bash
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 7878/tcp
sudo ufw default deny incoming 
sudo ufw default allow outgoing
echo "y" | sudo ufw enable


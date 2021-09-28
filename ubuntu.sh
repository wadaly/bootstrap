#!/bin/bash

add-apt-repository --yes --update ppa:ansible/ansible
apt -y install ansible

apt -y install curl
apt -y install vim
apt -y install inetutils-ping
apt -y install nginx

#systemctl enable nginx
service nginx start --enabled

#!/bin/bash

FILE_SHARE="https://raw.githubusercontent.com/wadaly/bootstrap/main/ansible_isam/files"

# This script assumes that apt-get update has already been run
# on the host and that curl has already been installed.

# Check that this script is not being rerun by checking for the
# presence of the /home/ansible directory.
[ -d /home/ansible ] && echo "Host setup previously completed. Exiting!" >&1 && exit 0

echo "Installing software-properties-common..."
apt -y install software-properties-common >/dev/null 2>&1

echo "Installing ansible git inetutils-ping vi..."
apt-get install -y ansible git inetutils-ping vim >/dev/null 2>&1

echo "Creating user <ansible>..."
adduser --disabled-password --gecos "" ansible >/dev/null 2>&1

printf "\n\nPYTHONPATH=/home/ansible/ibmsecurity\n" >> /home/ansible/.profile

su - ansible -c "curl $FILE_SHARE/ansible/home/ansible/ansible.cfg > /home/ansible/ansible.cfg"

su - ansible -c "git clone https://github.com/IBM-Security/ibmsecurity.git" >/dev/null 2>&1
su - ansible -c "git clone https://github.com/IBM-Security/isam-support.git" >/dev/null 2>&1
su - ansible -c "git clone https://github.com/IBM-Security/isam-ansible-collection.git" >/dev/null 2>&1
su - ansible -c "git clone https://github.com/IBM-Security/isam-ansible-roles.git" >/dev/null 2>&1

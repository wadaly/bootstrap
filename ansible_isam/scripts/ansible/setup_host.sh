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

echo "Updating /home/ansible/.profile..."
printf "\n\nexport PYTHONPATH=/home/ansible/ibmsecurity\n" >> /home/ansible/.profile

echo "Downloading ansible.cfg..."
su - ansible -c "curl $FILE_SHARE/ansible/home/ansible/ansible.cfg > /home/ansible/ansible.cfg"

echo "Creating Ansible inventory..."
su - ansible -c "mkdir /home/ansible/inventory" >/dev/null 2>&1
su - ansible -c "curl $FILE_SHARE/ansible/home/ansible/inventory/hosts > /home/ansible/inventory/hosts"

echo "Downloading isam_playbook.yml..."
su - ansible -c "curl $FILE_SHARE/ansible/home/ansible/isam.yml > /home/ansible/isam.yml"

echo "Downloading isam.env..."
su - ansible -c "curl $FILE_SHARE/ansible/home/ansible/isam.env > /home/ansible/isam.env"

echo "Cloning ISAM Ansible repositories..."
su - ansible -c "git clone https://github.com/IBM-Security/ibmsecurity.git" >/dev/null 2>&1
su - ansible -c "git clone https://github.com/IBM-Security/isam-support.git" >/dev/null 2>&1
su - ansible -c "git clone https://github.com/IBM-Security/isam-ansible-collection.git" >/dev/null 2>&1
su - ansible -c "git clone https://github.com/IBM-Security/isam-ansible-roles.git" >/dev/null 2>&1

#!/bin/bash
component=$1

# Use dnf for RHEL9 (not yum)
sudo dnf install ansible -y

cd /home/ec2-user

# Clone repo
rm -rf ansible-roboshop-roles-tf  # Clean previous
git clone https://github.com/rreddyga/ansible-roboshop-roles-tf.git
cd ansible-roboshop-roles-tf

git pull

# Run playbook with inventory
ansible-playbook -e component=$component roboshop.yaml

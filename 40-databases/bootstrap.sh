#!/bin/bash
component=$1
dnf install ansible -y 

#clone the ansible-roboshop-roles-tf repo
cd /home/ec2-user
git clone https://github.com/rreddyga/ansible-roboshop-roles-tf.git
#change the directory to ansible-roboshop-roles-tf
cd ansible-roboshop-roles-tf
#run the ansible playbook
ansible-playbook -e component=$component roboshop.yaml
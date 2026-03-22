#!/bin/bash
component=$1

# Use dnf for RHEL9 (not yum)
sudo dnf install -y ansible git

cd /home/ec2-user

# Clone repo
rm -rf ansible-roboshop-roles-tf  # Clean previous
git clone https://github.com/rreddyga/ansible-roboshop-roles-tf.git
cd ansible-roboshop-roles-tf

# Create inventory for localhost as "{{ component }}" group
sudo mkdir -p /etc/ansible
cat > inventory.ini << EOF
[${component}]
localhost ansible_connection=local ansible_python_interpreter=/usr/bin/python3

[all:vars]
ansible_connection=local
EOF

# Run playbook with inventory
ansible-playbook -i inventory.ini -e component=$component roboshop.yaml -b -K

echo "Bootstrap complete for $component"

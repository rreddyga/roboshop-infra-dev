#!/bin/bash
yum update -y

# Detect NVMe device (root disk)
ROOT_DISK=$(lsblk -dno NAME,SIZE,MOUNTPOINT | grep '[0-9]\+G /$' | awk '{print "/dev/" $1}')
if [ -z "$ROOT_DISK" ]; then
  echo "Root disk not found!"
  exit 1
fi
echo "Resizing $ROOT_DISK..."

# Install tools if needed
yum install -y cloud-utils-growpart lvm2 xfsprogs

# Extend partition (p3 for LVM PV on RHEL; common GPT layout)
growpart "$ROOT_DISK" 3

# Rescan PV, extend VG/LV, resize FS (root usually /dev/mapper/RootVG-rootVol or home)
pvresize "$ROOT_DISK"p3
lvextend -l +100%FREE -r /dev/RootVG/rootVol  # Adjust LV if /home: /dev/RootVG-homeVol
# For /home specifically: lvextend -l +100%FREE -r /dev/mapper/RootVG-homeVol

# Verify
df -h / /home
lsblk

# Install Terraform
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install terraform
terraform --version

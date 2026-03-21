#!/bin/bash
yum update -y

# Find root disk and LVM partition dynamically
ROOT_DISK=$(lsblk -no NAME,MOUNTPOINT | grep '/$' | awk '{print $1}')
echo "Found root disk: $ROOT_DISK"

# List partitions to identify LVM PV (usually p2/p3)
lsblk $ROOT_DISK
PART_NUM=$(pvs --noheadings -o pv_name | grep $ROOT_DISK | awk '{print $1}' | sed "s|$ROOT_DISK||")
echo "LVM partition: $ROOT_DISK$PART_NUM"

# Safe resize sequence
yum install -y cloud-utils-growpart lvm2 xfsprogs
growpart $ROOT_DISK $PART_NUM
pvresize $ROOT_DISK$PART_NUM
lvextend -l +100%FREE /dev/RootVG/homeVol
xfs_growfs /home

df -h /home
lvs

echo 'export TF_CLI_ARGS="-no-color"' >> /root/.bashrc
echo 'ulimit -v unlimited' >> /root/.bashrc


# Terraform install
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install terraform

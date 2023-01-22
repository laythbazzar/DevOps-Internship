#!/bin/sh

#make partitions
fdisk /dev/sdb

#create physical volume
pvcreate /dev/sdb1

#create new volume group each extent has size of 16M
vgcreate -s 16M lv /dev/sdb1

#create new logic group with 50 extents
lvcreate -l 50 -n lv /dev/lv

#format the file to filestystem type ext4
mkfs -t ext4 /dev/mapper/lv-lv

#creating dir to mount on
mkdir /mnt/data

# define the file system using UUID on /mnt/data as ext4 type with default options
# no backup by dump and o fsck check
id=$(blkid |grep -w 'lv'| awk '{print $2}')
echo "$id /mnt/data ext4 defaults 0 4" >> /etc/fstab


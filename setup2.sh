#!/bin/bash

# set hostname
echo -n "enter desired fully qualified hostname: "
read HOSTNAME
sudo hostnamectl set-hostname $HOSTNAME

# setup some swap
sudo dd if=/dev/zero of=/swapfile bs=1M count=8192
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo sh -c "echo '/swapfile swap swap defaults 0 0'>>/etc/fstab"

# create ubuntu user with sudo privileges

deluser user
useradd ubuntu -u 1000 && echo "ubuntu:ubuntu" | chpasswd && adduser ubuntu sudo
sed -i /etc/sudoers -re 's/^%sudo.*/%sudo   ALL=(ALL:ALL) NOPASSWD: ALL/g'
mkdir /home/ubuntu
chown ubuntu:ubuntu /home/ubuntu

echo 'You will still need to set up some authorized_keys'
echo 'Also please set `PermitRootLogin no`'
echo '`PasswordAuthentication no` and `ChallengeResponseAuthentication no`'

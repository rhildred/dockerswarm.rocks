#!/bin/bash

sudo apt update
sudo apt install git drbd8-utils heartbeat linux-image-extra-virtual ntpdate tzdata ec2-api-tools ec2-ami-tools awscli ifupdown nfs-kernel-server

echo -n "enter desired fully qualified hostname: "
read HOSTNAME
sudo hostnamectl set-hostname $HOSTNAME

# setup some swap
sudo dd if=/dev/zero of=/swapfile bs=1M count=8192
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo sh -c "echo '/swapfile swap swap defaults 0 0'>>/etc/fstab"

# do the initial docker setup
sudo apt install docker.io
sudo service docker start
sudo usermod -a -G docker ubuntu
sudo systemctl enable docker

# add compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

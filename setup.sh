#!/bin/bash

sudo apt update
sudo apt install git drbd8-utils heartbeat linux-image-extra-virtual ntpdate tzdata ec2-api-tools ec2-ami-tools awscli ifupdown nfs-kernel-server
sudo systemctl start drbd
sudo systemctl start heartbeat
sudo systemctl enable drbd
sudo systemctl enable heartbeat
sudo systemctl stop nfs-kernel-server
sudo systemctl disable nfs-kernel-server
sudo ln -s /etc/init.d/nfs-kernel-server /etc/ha.d/resource.d/nfs-kernel-server
sudo sh -c "echo -e 'n\np\n1\n\n\nw' | fdisk /dev/nvme0n1"
sudo sh -c 'echo "2 eth1_rt" >> /etc/iproute2/rt_tables'

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

# use article https://www.howtoforge.com/tutorial/ubuntu-drbd-heartbeat-high-availability/

# then do hosts so that the partners can see each other

# then go through the rest of the files in the scripts folder. Don't forget to chmod +x vipup

# then do the drbd metadata and sync watch with `watch -n1 cat /proc/drbd`

# then put /var/lib/nfs on the shared drive along with /etc/exports and link on both machines

# then put the line for the /g drive in the /etc/fstab

# then reinit and it should come up???

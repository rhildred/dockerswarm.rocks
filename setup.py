#!/usr/bin/env python

# this is a script that can be run on a series of amazon linux 2 machines to set up a docker swarm

import subprocess

#missing packages
subprocess.call("sudo yum -y update", shell=True)
subprocess.call("sudo yum -y install git amazon-efs-utils", shell=True)

#hostname
sHostName = raw_input("enter desired fully qualified hostname: ")
subprocess.call(["sudo", "hostnamectl", "set-hostname",  sHostName])

# setup some swap
subprocess.call("sudo dd if=/dev/zero of=/swapfile bs=1M count=8192", shell=True)
subprocess.call(["sudo", "chmod","600", "/swapfile"])
subprocess.call(["sudo", "mkswap", "/swapfile"])
subprocess.call(["sudo", "swapon", "/swapfile"])
subprocess.call("sudo sh -c \"echo '/swapfile swap swap defaults 0 0'>>/etc/fstab\"", shell=True)

# mount the data volume
subprocess.call("sudo mkdir /h", shell=True)
subprocess.call("sudo sh -c \"echo 'esgaroth.selab.ca:/h /h nfs rw 0 0'>>/etc/fstab\"", shell=True)
subprocess.call("sudo mount -a", shell=True)

# do the initial docker setup
subprocess.call("sudo amazon-linux-extras install docker", shell=True)
subprocess.call("sudo service docker start", shell=True)
subprocess.call("sudo usermod -a -G docker ec2-user", shell=True)
subprocess.call("sudo systemctl enable docker", shell=True)

# add compose
subprocess.call("sudo curl -L \"https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose", shell=True)
subprocess.call("sudo chmod +x /usr/local/bin/docker-compose")

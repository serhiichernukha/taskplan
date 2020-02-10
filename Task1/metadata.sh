#!/bin/bash
sudo yum update -y

#Instal Packeges
sudo yum install wget -y
sudo yum install htop -y
sudo yum install git -y
sudo yum install vim -y

#Install Docker Community Edition
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo gpasswd -a intkoost docker
sudo yum install docker-compose -y
sudo reboot

#!/bin/bash
source functions/f_update_software.sh
f_update_software
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
sudo groupadd docker
sudo usermod -aG docker $USER
echo "Docker is now installed!"
sudo systemctl stop docker.socket
sudo systemctl stop docker.service
sudo cp -r docker/install_server_docker.json /etc/docker/daemon.json
sudo systemctl start docker.socket
sudo systemctl start docker.service

sudo su - $USER
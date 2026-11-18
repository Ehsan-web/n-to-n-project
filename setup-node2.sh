#!/bin/bash

sudo apt-get update -y
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker vagrant

sudo docker run -d --name web1 -p 8081:80 nginxdemos/hello
sudo docker run -d --name web2 -p 8082:80 nginxdemos/hello
sudo docker run -d --name web3 -p 8083:80 nginxdemos/hello

echo "Node 2 setup completed."

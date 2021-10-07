#!/bin/sh
#install docker: 
#https://www.linuxtechi.com/install-use-docker-on-ubuntu/

sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable"

sudo apt-get update
sudo apt install docker-ce -y
sudo systemctl status docker
sudo usermod -a -G docker $USER
newgrp docker
docker version
docker run hello-world

#--------------------------------------------------------------------------------


#install kubernetes (minikube)
#https://www.linuxtechi.com/how-to-install-minikube-on-ubuntu/

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y curl wget apt-transport-https
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo cp minikube-linux-amd64 /usr/local/bin/minikube
sudo chmod +x /usr/local/bin/minikube
minikube version
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version -o yaml
# minikube start --driver=docker


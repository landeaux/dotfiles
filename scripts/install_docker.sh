#!/usr/bin/env bash

# uninstall old versions
sudo apt-get remove docker docker-engine docker.io containerd runc

# set up the repository
sudo apt-get install ca-certificates curl gnupg lsb-release

# add docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# set up the stable repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

# update the package index again
sudo apt-get update

# install docker engine
sudo apt-get install docker-ce docker-ce-cli containerd.io

# create docker group
sudo groupadd docker

# add $USER to docker group
sudo usermod -aG docker "$USER"

# apply the new group changes without logging out
newgrp docker

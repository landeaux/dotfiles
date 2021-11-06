#!/usr/bin/env bash

# install dependencies
sudo apt-get update
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
  libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils \
  tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# clone pyenv
pyenv_root=~/.pyenv
git clone https://github.com/pyenv/pyenv.git "${pyenv_root}"

# install pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-virtualenv.git "${pyenv_root}"/plugins/pyenv-virtualenv

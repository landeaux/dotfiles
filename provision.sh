#!/usr/bin/env bash

# run system configuration commands
setxkbmap -option caps:escape  # re-map caps-lock to escape

########## update apt and upgrade packages
sudo apt update  # update apt package index
sudo apt upgrade -y  # upgrade existing packages

########## install additional packages
sudo apt install -y build-essential git curl wget tree xclip tmux

########## install docker
# see scripts/install_docker.sh

########## install zsh and oh-my-zsh
# see scripts/install_zsh.sh

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install marker
git clone --depth=1 https://github.com/pindexis/marker ~/.marker && ~/.marker/install.py

########## install pyenv + plugins
# see scripts/install_pyenv.sh

########## install kitty
# see scripts/install_kitty.sh

# install fonts

# install neovim

# install nvm (node + npm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
command -v nvm
nvm install --lts

# install neovim package dependencies
# - python3.8-venv
# - ripgrep (for telescope)
# - efm linters (black, flake8, prettier, etc.)

# create Development dir and cd into it

# git clone dotfiles and cd into it

# run dotfiles install

# change default shell to zsh

# open kitty terminal

# run nvim

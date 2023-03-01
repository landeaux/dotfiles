#!/usr/bin/env bash

# run system configuration commands
setxkbmap -option caps:escape # re-map caps-lock to escape (NOTE: this doesn't seem to be persistant between logins)

########## update apt and upgrade packages
sudo apt update     # update apt package index
sudo apt upgrade -y # upgrade existing packages
sudo apt autoremove # clean up packages no longer needed

########## install additional packages
sudo apt install -y build-essential git curl tree xclip tmux

########## install zsh and oh-my-zsh
# see scripts/install_zsh.sh

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# install marker
# NOTE: this install script tries to call python (via /usr/bin/env python),
# but new versions of Ubuntu don't have python, they have python3. Symlinking
# /usr/bin/python to /usr/bin/python3 should do the trick
[ ! -e /usr/bin/python ] && [ -e /usr/bin/python3 ] && sudo ln -s /usr/bin/python3 /usr/bin/python
git clone --depth=1 https://github.com/pindexis/marker ~/.marker
~/.marker/install.py

########## install pyenv + plugins
# see scripts/install_pyenv.sh

########## install nvm (node + npm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
command -v nvm
nvm install --lts

########## install docker
# see scripts/install_docker.sh

########## install fonts
# TODO

########## install kitty
# see scripts/install_kitty.sh

########## install neovim
curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o ~/.local/bin/nvim
chmod +x ~/.local/bin/nvim

########## install neovim package dependencies
sudo apt install python3.8-venv ripgrep
npm install -g eslint_d @fsouza/prettierd markdownlint-cli

# create Development dir and cd into it

# git clone dotfiles and cd into it

# run dotfiles install

# change default shell to zsh

# open kitty terminal

# run nvim

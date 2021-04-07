#!/usr/bin/env bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# tmux
rm ~/.tmux.conf
ln -s ${BASEDIR}/tmux.conf ~/.tmux.conf

# zsh
rm ~/.zshrc
ln -s ${BASEDIR}/zshrc ~/.zshrc

# neovim
rm -rf ~/.config/nvim && mkdir -p ~/.config/nvim
ln -s ${BASEDIR}/init.lua ~/.config/nvim/init.lua
ln -s ${BASEDIR}/lua ~/.config/nvim/lua
ln -s ${BASEDIR}/coc-settings.json ~/.config/nvim/coc-settings.json

# git
rm ~/.gitconfig && rm ~/.gitignore && rm ~/.gitmessage
ln -s ${BASEDIR}/gitconfig ~/.gitconfig
ln -s ${BASEDIR}/gitignore ~/.gitignore
ln -s ${BASEDIR}/gitmessage ~/.gitmessage

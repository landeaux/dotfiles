#!/usr/bin/env bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# tmux
rm ~/.tmux.conf
ln -s ${BASEDIR}/tmux.conf ~/.tmux.conf
tmux source-file ~/.tmux.conf

# zsh
rm ~/.zshrc
ln -s ${BASEDIR}/zshrc ~/.zshrc
# source ~/.zshrc

# neovim
rm -rf ~/.config/nvim
ln -s ${BASEDIR}/nvim ~/.config/nvim

# git
rm ~/.gitconfig && rm ~/.gitignore && rm ~/.gitmessage
ln -s ${BASEDIR}/gitconfig ~/.gitconfig
ln -s ${BASEDIR}/gitignore ~/.gitignore
ln -s ${BASEDIR}/gitmessage ~/.gitmessage

# pylint
rm ~/.config/pylintrc
ln -s ${BASEDIR}/pylintrc ~/.config/pylintrc

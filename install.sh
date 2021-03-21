#!/usr/bin/env bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# tmux
ln -s ${BASEDIR}/tmux.conf ~/.tmux.conf

# zsh
ln -s ${BASEDIR}/zshrc ~/.zshrc

# neovim
ln -s ${BASEDIR}/init.vim ~/.config/nvim/init.vim
ln -s ${BASEDIR}/coc-settings.json ~/.config/nvim/coc-settings.json

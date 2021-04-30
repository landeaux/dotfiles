#!/usr/bin/env bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# tmux
rm ~/.tmux.conf
ln -s "${BASEDIR}/tmux.conf" "${HOME}/.tmux.conf"
[ -n "$TMUX" ] && tmux source-file ~/.tmux.conf

# zsh
rm ~/.zshrc
ln -s "${BASEDIR}/zshrc" "${HOME}/.zshrc"
# source ~/.zshrc

# neovim
rm -rf ~/.config/nvim
ln -s "${BASEDIR}/nvim" "${HOME}/.config/nvim"

# git
rm ~/.gitconfig && rm ~/.gitignore && rm ~/.gitmessage
ln -s "${BASEDIR}/gitconfig" "${HOME}/.gitconfig"
ln -s "${BASEDIR}/gitignore" "${HOME}/.gitignore"
ln -s "${BASEDIR}/gitmessage" "${HOME}/.gitmessage"

# pylint
rm ~/.config/pylintrc
ln -s "${BASEDIR}/pylintrc" "${HOME}/.config/pylintrc"

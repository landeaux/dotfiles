#!/usr/bin/env bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# tmux
[ -f ~/.tmux.conf ] && rm ~/.tmux.conf
ln -s "${BASEDIR}/tmux.conf" "${HOME}/.tmux.conf"
[ -n "$TMUX" ] && tmux source-file ~/.tmux.conf
tic -x ./terminfo/tmux-256color.terminfo # custom terminfo w/ italics

# zsh
[ -f ~/.zshrc ] && rm ~/.zshrc
[ -f ~/.zprofile ] && rm ~/.zprofile
ln -s "${BASEDIR}/zshrc" "${HOME}/.zshrc"
ln -s "${BASEDIR}/zprofile" "${HOME}/.zprofile"

# neovim
[ -d ~/.config/nvim ] && rm -rf ~/.config/nvim
ln -s "${BASEDIR}/nvim" "${HOME}/.config/nvim"

# kitty
[ -e "${HOME}/.config/kitty/kitty.conf" ] && rm "${HOME}/.config/kitty/kitty.conf"
[ -e "${HOME}/.config/kitty/kitty_tokyonight_night.conf" ] && rm "${HOME}/.config/kitty/kitty_tokyonight_night.conf"
mkdir -p "${HOME}/.config/kitty"
ln -s "${BASEDIR}/kitty/kitty.conf" "${HOME}/.config/kitty/kitty.conf"
ln -s "${BASEDIR}/kitty/kitty_tokyonight_night.conf" "${HOME}/.config/kitty/kitty_tokyonight_night.conf"

# efm
EFM_CONFIG_PATH="$HOME/.config/efm-langserver/config.yaml"
[ -f "${EFM_CONFIG_PATH}" ] && rm "$EFM_CONFIG_PATH"
ln -s "${BASEDIR}/efm-langserver/config.yaml" "$EFM_CONFIG_PATH"

# git
[ -f ~/.gitconfig ] && rm ~/.gitconfig
[ -f ~/.gitignore ] && rm ~/.gitignore
[ -f ~/.gitmessage ] && rm ~/.gitmessage
ln -s "${BASEDIR}/gitconfig" "${HOME}/.gitconfig"
ln -s "${BASEDIR}/gitignore" "${HOME}/.gitignore"
ln -s "${BASEDIR}/gitmessage" "${HOME}/.gitmessage"

# pylint
[ -f ~/.config/pylintrc ] && rm ~/.config/pylintrc
ln -s "${BASEDIR}/pylintrc" "${HOME}/.config/pylintrc"

# stylua
[ -f ~/.config/stylua.toml ] && rm ~/.config/stylua.toml
ln -s "${BASEDIR}/stylua.toml" "${HOME}/.config/stylua.toml"

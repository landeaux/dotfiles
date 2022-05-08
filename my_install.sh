#!/usr/bin/env bash

set -e

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# tmux
tmux_conf_path="${HOME}/.tmux.conf"
tmux_home_path="${HOME}/.tmux"
mkdir -p "${tmux_home_path}"
ln -sfn "${BASEDIR}/tmux/tmux.conf" "$tmux_conf_path"
find tmux -name '*.proj' |
	awk -F '/' '{print $2}' |
	xargs -I {} bash -c "ln -sfn '${BASEDIR}/tmux/{}' '${tmux_home_path}/{}'"
[ -n "$TMUX" ] && tmux source-file "$tmux_conf_path"
tic -x ./terminfo/tmux-256color.terminfo # custom terminfo w/ italics

# zsh
ln -sfn "${BASEDIR}/zshrc" "${HOME}/.zshrc"
ln -sfn "${BASEDIR}/zshenv" "${HOME}/.zshenv"

# neovim
ln -sfn "${BASEDIR}/nvim" "${HOME}/.config/nvim"

# kitty
mkdir -p "${HOME}/.config/kitty"
ln -sfn "${BASEDIR}/kitty/kitty.conf" "${HOME}/.config/kitty/kitty.conf"
ln -sfn "${BASEDIR}/kitty/kitty_tokyonight_night.conf" "${HOME}/.config/kitty/kitty_tokyonight_night.conf"

# git
ln -sfn "${BASEDIR}/gitconfig" "${HOME}/.gitconfig"
ln -sfn "${BASEDIR}/gitignore" "${HOME}/.gitignore"
ln -sfn "${BASEDIR}/gitmessage" "${HOME}/.gitmessage"

# marker
ln -sfn "${BASEDIR}/marker/user_commands.txt" "${HOME}/.local/share/marker/user_commands.txt"

# custom bin
ln -sfn "${BASEDIR}/bin" "${HOME}/bin"

# add .dotfiles symlink to this directory
ln -sfn "${BASEDIR}" "${HOME}/.dotfiles"

#!/usr/bin/env bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

rm_and_symlink() {
	[ -e "$1" ] && rm -rf "$1"
	ln -s "$2" "$1"
}
export -f rm_and_symlink

# tmux
tmux_conf_path="${HOME}/.tmux.conf"
tmux_home_path="${HOME}/.tmux"
mkdir -p "${tmux_home_path}"
rm_and_symlink "$tmux_conf_path" "${BASEDIR}/tmux/tmux.conf"
find tmux -name '*.proj' \
	| awk -F '/' '{print $2}' \
	| xargs -I {} bash -c "rm_and_symlink '${tmux_home_path}/{}' '${BASEDIR}/tmux/{}'"
[ -n "$TMUX" ] && tmux source-file "$tmux_conf_path"
tic -x ./terminfo/tmux-256color.terminfo # custom terminfo w/ italics

# zsh
rm_and_symlink "${HOME}/.zshrc" "${BASEDIR}/zshrc"
rm_and_symlink "${HOME}/.zprofile" "${BASEDIR}/zprofile"

# neovim
rm_and_symlink "${HOME}/.config/nvim" "${BASEDIR}/nvim"

# kitty
mkdir -p "${HOME}/.config/kitty"
rm_and_symlink "${HOME}/.config/kitty/kitty.conf" "${BASEDIR}/kitty/kitty.conf"
rm_and_symlink "${HOME}/.config/kitty/kitty_tokyonight_night.conf" "${BASEDIR}/kitty/kitty_tokyonight_night.conf"

# efm
rm_and_symlink "$HOME/.config/efm-langserver/config.yaml" "${BASEDIR}/efm-langserver/config.yaml"

# git
rm_and_symlink "${HOME}/.gitconfig" "${BASEDIR}/gitconfig"
rm_and_symlink "${HOME}/.gitignore" "${BASEDIR}/gitignore"
rm_and_symlink "${HOME}/.gitmessage" "${BASEDIR}/gitmessage"

# pylint
rm_and_symlink "${HOME}/.config/pylintrc" "${BASEDIR}/pylintrc"

# stylua
rm_and_symlink "${HOME}/.config/stylua.toml" "${BASEDIR}/stylua.toml"

# custom bin
rm_and_symlink "${HOME}/bin" "${BASEDIR}/bin"

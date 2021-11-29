#!/usr/bin/env bash

install_on_linux() {
	if command -v nvim 1>/dev/null 2>&1; then
		sudo rm "$(command -v nvim)"
	fi
	HOME_LOCAL_BIN_PATH="${HOME}/.local/bin"
	NVIM_BIN_PATH="${HOME_LOCAL_BIN_PATH}/nvim"
	mkdir -p "${HOME_LOCAL_BIN_PATH}"
	curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o "${NVIM_BIN_PATH}"
	chmod +x "${NVIM_BIN_PATH}"
}

install_on_macos() {
	brew uninstall neovim
	brew cleanup --prune=all
	brew install --HEAD neovim
}

case "$OSTYPE" in
darwin*) install_on_macos ;;
linux*) install_on_linux ;;
*) echo "unknown: $OSTYPE" && exit 1 ;;
esac

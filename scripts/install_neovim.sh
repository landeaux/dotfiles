#!/usr/bin/env bash

set -e

for i in "$@"; do
	case $i in
	--nightly)
		NIGHTLY=1
		;;
	*)
		echo "unknown option: ${i}"
		exit 1
		;;
	esac
done

install_on_linux() {
	if command -v nvim 1>/dev/null 2>&1; then
		sudo rm "$(command -v nvim)"
	fi

	HOME_LOCAL_BIN_PATH="${HOME}/.local/bin"
	mkdir -p "${HOME_LOCAL_BIN_PATH}"

	if [[ $NIGHTLY ]]; then
		NVIM_TAG=nightly
	else
		NVIM_TAG=v0.6.0
	fi

	BASE_URL="https://github.com/neovim/neovim/releases/download/${NVIM_TAG}"

	NVIM_APPIMAGE_NAME="nvim.appimage"
	curl -L -O "${BASE_URL}/${NVIM_APPIMAGE_NAME}"

	NVIM_CHECKSUM_NAME="${NVIM_APPIMAGE_NAME}.sha256sum"
	curl -L -O "${BASE_URL}/${NVIM_CHECKSUM_NAME}"
	sha256sum -c "${NVIM_CHECKSUM_NAME}"
	rm "${NVIM_CHECKSUM_NAME}"

	NVIM_BIN_PATH="${HOME_LOCAL_BIN_PATH}/nvim"
	mv "${NVIM_APPIMAGE_NAME}" "${NVIM_BIN_PATH}"
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
*) echo "unknown OSTYPE: $OSTYPE" && exit 1 ;;
esac

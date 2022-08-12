#!/usr/bin/env bash

set -euxo pipefail

NIGHTLY=0
USE_BREW=0

for i in "$@"; do
	case $i in
	--nightly)
		NIGHTLY=1
		;;
	--use-brew)
		USE_BREW=1
		;;
	*)
		echo "unknown option: ${i}"
		exit 1
		;;
	esac
done

if [[ $NIGHTLY -eq "1" ]]; then
  NVIM_TAG=nightly
else
  NVIM_TAG=v0.7.2
fi

install_on_linux() {
	if command -v nvim 1>/dev/null 2>&1; then
		sudo rm "$(command -v nvim)"
	fi

	HOME_LOCAL_BIN_PATH="${HOME}/.local/bin"
	mkdir -p "${HOME_LOCAL_BIN_PATH}"
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

install_on_mac() {
	if [[ $USE_BREW -eq "1" ]]; then
		install_on_macos_with_brew
	else
		install_on_mac_from_repo
	fi
}

install_on_mac_from_repo() {
	if command -v nvim 1>/dev/null 2>&1; then
		sudo rm "$(command -v nvim)"
	fi

	HOME_LOCAL_BIN_PATH="${HOME}/.local/bin"
	mkdir -p "${HOME_LOCAL_BIN_PATH}"

	NVIM_DIR_NAME="nvim-macos
	NVIM_DIR_PATH="${HOME_LOCAL_BIN_PATH}/${NVIM_DIR_NAME}"

	if [[ -d "${NVIM_DIR_PATH}" ]]; then
		rm -rf "${NVIM_DIR_PATH}"
	fi

	BASE_URL="https://github.com/neovim/neovim/releases/download/${NVIM_TAG}"

	NVIM_TARBALL_NAME="nvim-macos.tar.gz"
	curl -L -O "${BASE_URL}/${NVIM_TARBALL_NAME}"

	NVIM_CHECKSUM_NAME="${NVIM_TARBALL_NAME}.sha256sum"
	curl -L -O "${BASE_URL}/${NVIM_CHECKSUM_NAME}"
	shasum -a 256 -c "${NVIM_CHECKSUM_NAME}"
	rm "${NVIM_CHECKSUM_NAME}"

	tar -xzf "${NVIM_TARBALL_NAME}"
	mv "${NVIM_DIR_NAME}" "${HOME_LOCAL_BIN_PATH}"
	NVIM_BIN_PATH="${NVIM_DIR_PATH}/bin/nvim"
	chmod +x "${NVIM_BIN_PATH}"
	ln -s "${NVIM_BIN_PATH}" "${HOME_LOCAL_BIN_PATH}/nvim"
  rm "${NVIM_TARBALL_NAME}"
}

install_on_macos_with_brew() {
	brew uninstall neovim
	brew cleanup --prune=all
	if [[ $NIGHTLY -eq "1" ]]; then
		brew install --HEAD neovim
	else
		brew install neovim
	fi
}

case "$OSTYPE" in
darwin*) install_on_mac ;;
linux*) install_on_linux ;;
*) echo "unknown OSTYPE: $OSTYPE" && exit 1 ;;
esac

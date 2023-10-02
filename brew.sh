#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim
brew install grep
brew install openssh
brew install screen
brew install php

# Install other useful binaries.
brew install ack
brew install bat
brew install direnv
brew install entr
brew install fd
brew install git
brew install git-extras
brew install git-lfs
brew install glab
brew install goku # for writing karabiner.json
brew install hadolint
brew install hyperfine
brew install jq
brew install lua
brew install luarocks
brew install neovim
brew install rename
brew install ripgrep
brew install shellcheck
brew install shfmt
brew install ssh-copy-id
brew install starship # for shell prompt
brew install task
brew install tmux
brew install tree
brew install tree-sitter
brew install wget

# Install yabai (tiling window manager) and skhd (hotkey daemon)
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd

# Install qmk
brew install qmk/qmk/qmk

# Install pyenv dependencies
brew install libb2 # Fixes blake2b hash issue. See https://github.com/pyenv/pyenv/issues/2573#issuecomment-1415335052
# Install pyenv python build dependencies
brew install openssl readline sqlite3 xz zlib tcl-tk

# Install fzf
brew install fzf
"$BREW_PREFIX"/opt/fzf/install # To install useful key bindings and fuzzy completion

# Install Fonts
brew tap homebrew/cask-fonts
brew install font-jetbrains-mono
brew install font-symbols-only-nerd-font

# Install a modern version of Zsh.
brew install zsh
# brew install zsh-completions  # NOTE: may not need with oh-my-zsh

# Switch to using brew-installed zsh as default shell
if ! grep "${BREW_PREFIX}/bin/zsh" /etc/shells &>/dev/null; then
  echo "${BREW_PREFIX}/bin/zsh" | sudo tee -a /etc/shells
  chsh -s "${BREW_PREFIX}/bin/zsh"
fi

# Install kitty terminal
brew install --cask kitty

# Remove outdated versions from the cellar.
brew cleanup

#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we're using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install everything from the Brewfile.
brew bundle --file=~/dotfiles/Brewfile

# Save Homebrew's installed location.
BREW_PREFIX=$(brew --prefix)

# Switch to using brew-installed zsh as default shell
if ! grep "${BREW_PREFIX}/bin/zsh" /etc/shells &>/dev/null; then
  echo "${BREW_PREFIX}/bin/zsh" | sudo tee -a /etc/shells
  chsh -s "${BREW_PREFIX}/bin/zsh"
fi

# Remove outdated versions from the cellar.
brew cleanup

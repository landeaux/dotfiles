#!/usr/bin/env bash
set -e

DOTFILES_REPO="https://github.com/landeaux/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

# Install Xcode Command Line Tools (macOS only)
if [[ "$(uname)" == "Darwin" ]]; then
  if ! xcode-select -p &>/dev/null; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
    until xcode-select -p &>/dev/null; do
      sleep 5
    done
  fi
fi

# Install Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl --proto '=https' --tlsv1.2 -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ "$(uname -m)" == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

# Clone or update dotfiles
if [[ -d "$DOTFILES_DIR" ]]; then
  echo "Dotfiles repo already exists, pulling latest..."
  git -C "$DOTFILES_DIR" pull
else
  echo "Cloning dotfiles..."
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

# Hand off to bootstrap
exec "$DOTFILES_DIR/scripts/bootstrap.sh"

#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

###############################################################################
# Homebrew packages
###############################################################################

echo "Updating Homebrew..."
brew update

echo "Installing Brewfile packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

brew cleanup

###############################################################################
# oh-my-zsh
###############################################################################

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "Installing oh-my-zsh..."
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl --proto '=https' --tlsv1.2 -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "oh-my-zsh already installed."
fi

###############################################################################
# Rust (rustup)
###############################################################################

if [[ ! -f "$HOME/.cargo/bin/rustc" ]]; then
  echo "Installing rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
else
  echo "Rust already installed."
fi

###############################################################################
# Claude Code
###############################################################################

if ! command -v claude &>/dev/null; then
  echo "Installing Claude Code..."
  curl --proto '=https' --tlsv1.2 -fsSL https://claude.ai/install.sh | bash
else
  echo "Claude Code already installed."
fi

###############################################################################
# nvm — install default Node version
###############################################################################

export NVM_DIR="$HOME/.nvm"
BREW_PREFIX="$(brew --prefix)"
if [[ -s "$BREW_PREFIX/opt/nvm/nvm.sh" ]]; then
  # shellcheck source=/dev/null
  . "$BREW_PREFIX/opt/nvm/nvm.sh"
  if ! nvm ls default &>/dev/null || [[ "$(nvm ls default --no-colors 2>&1)" == *"N/A"* ]]; then
    echo "Installing default Node version (LTS)..."
    nvm install --lts
  else
    echo "Default Node version already installed."
  fi
fi

###############################################################################
# Default shell — switch to brew-installed zsh
###############################################################################

BREW_ZSH="$BREW_PREFIX/bin/zsh"
if [[ -x "$BREW_ZSH" ]]; then
  if ! grep -q "$BREW_ZSH" /etc/shells; then
    echo "Adding brew zsh to /etc/shells (requires sudo)..."
    echo "$BREW_ZSH" | sudo tee -a /etc/shells >/dev/null
  fi
  if [[ "$SHELL" != "$BREW_ZSH" ]]; then
    echo "Switching default shell to brew zsh..."
    chsh -s "$BREW_ZSH"
  else
    echo "Default shell is already brew zsh."
  fi
fi

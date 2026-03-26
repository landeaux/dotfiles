#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Installing prerequisites..."
"$DOTFILES_DIR/scripts/prerequisites.sh"

echo "==> Installing tools..."
"$DOTFILES_DIR/scripts/install_tools.sh"

echo "==> Linking dotfiles..."
"$DOTFILES_DIR/install"

if [[ "$(uname)" == "Darwin" ]]; then
  echo "==> Applying macOS defaults..."
  "$DOTFILES_DIR/scripts/macos_defaults.sh"
fi

echo "==> Done! You may need to restart your shell for all changes to take effect."

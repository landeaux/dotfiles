#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

case "$(uname)" in
  Darwin)
    "$DOTFILES_DIR/scripts/install_tools_macos.sh"
    ;;
  Linux)
    "$DOTFILES_DIR/scripts/install_tools_linux.sh"
    ;;
  *)
    echo "Unsupported OS: $(uname)" >&2
    exit 1
    ;;
esac

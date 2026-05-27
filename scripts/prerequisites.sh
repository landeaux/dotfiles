#!/usr/bin/env bash
set -e

case "$(uname)" in
  Darwin)
    # Install Xcode Command Line Tools
    if ! xcode-select -p &>/dev/null; then
      echo "Installing Xcode Command Line Tools..."
      xcode-select --install
      # Wait for installation to complete
      until xcode-select -p &>/dev/null; do
        sleep 5
      done
      echo "Xcode Command Line Tools installed."
    else
      echo "Xcode Command Line Tools already installed."
    fi

    # Install Homebrew
    if ! command -v brew &>/dev/null; then
      echo "Installing Homebrew..."
      /bin/bash -c "$(curl --proto '=https' --tlsv1.2 -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      # Add Homebrew to PATH for the rest of this session
      if [[ "$(uname -m)" == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      else
        eval "$(/usr/local/bin/brew shellenv)"
      fi
      echo "Homebrew installed."
    else
      echo "Homebrew already installed."
    fi
    ;;

  Linux)
    if ! command -v apt-get &>/dev/null; then
      echo "Unsupported Linux distribution: apt-get not found." >&2
      exit 1
    fi
    echo "Updating apt package index..."
    sudo apt-get update
    echo "Installing Linux prerequisites..."
    sudo apt-get install -y \
      build-essential \
      ca-certificates \
      curl \
      git \
      software-properties-common
    ;;

  *)
    echo "Unsupported OS: $(uname)" >&2
    exit 1
    ;;
esac

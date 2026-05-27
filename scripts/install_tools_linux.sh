#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

###############################################################################
# Apt packages
###############################################################################

echo "Installing apt packages from apt_packages.txt..."
# Strip comments and blank lines, then install in one apt-get call.
grep -v '^\s*\(#\|$\)' "$DOTFILES_DIR/apt_packages.txt" | xargs sudo apt-get install -y

###############################################################################
# Neovim — install from official GitHub release tarball (apt default is too
# old; the project publishes signed tarballs with a shasum manifest).
###############################################################################

if ! command -v nvim &>/dev/null; then
  echo "Installing Neovim from GitHub release tarball..."
  case "$(uname -m)" in
    x86_64) NVIM_ARCH="linux-x86_64" ;;
    aarch64 | arm64) NVIM_ARCH="linux-arm64" ;;
    *)
      echo "Unsupported architecture for Neovim tarball: $(uname -m)" >&2
      exit 1
      ;;
  esac
  NVIM_TARBALL="nvim-${NVIM_ARCH}.tar.gz"
  NVIM_BASE_URL="https://github.com/neovim/neovim/releases/latest/download"
  NVIM_TMP="$(mktemp -d)"
  curl -fL "${NVIM_BASE_URL}/shasum.txt" -o "${NVIM_TMP}/shasum.txt"
  curl -fL "${NVIM_BASE_URL}/${NVIM_TARBALL}" -o "${NVIM_TMP}/${NVIM_TARBALL}"
  # Verify checksum from the project's shasum.txt manifest.
  (cd "$NVIM_TMP" && grep " ${NVIM_TARBALL}\$" shasum.txt | sha256sum -c -)
  sudo rm -rf "/opt/nvim-${NVIM_ARCH}"
  sudo tar -C /opt -xzf "${NVIM_TMP}/${NVIM_TARBALL}"
  sudo ln -sf "/opt/nvim-${NVIM_ARCH}/bin/nvim" /usr/local/bin/nvim
  rm -rf "$NVIM_TMP"
else
  echo "Neovim already installed."
fi

###############################################################################
# Starship prompt (no apt package)
###############################################################################

if ! command -v starship &>/dev/null; then
  echo "Installing starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
else
  echo "Starship already installed."
fi

###############################################################################
# zoxide (apt version often lags)
###############################################################################

if ! command -v zoxide &>/dev/null; then
  echo "Installing zoxide..."
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
else
  echo "zoxide already installed."
fi

###############################################################################
# GitHub CLI (gh) — official apt repo
###############################################################################

if ! command -v gh &>/dev/null; then
  echo "Installing GitHub CLI (gh)..."
  sudo mkdir -p -m 755 /etc/apt/keyrings
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null
  sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
  sudo apt-get update
  sudo apt-get install -y gh
else
  echo "gh already installed."
fi

###############################################################################
# Rust (rustup) — same as macOS
###############################################################################

if [[ ! -f "$HOME/.cargo/bin/rustc" ]]; then
  echo "Installing rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
else
  echo "Rust already installed."
fi

###############################################################################
# nvm + Node LTS — same as macOS
###############################################################################

export NVM_DIR="$HOME/.nvm"
if [[ ! -d "$NVM_DIR" ]]; then
  echo "Installing nvm..."
  curl --proto '=https' --tlsv1.2 -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | PROFILE=/dev/null bash
else
  echo "nvm already installed."
fi

# shellcheck source=/dev/null
. "$NVM_DIR/nvm.sh"

if ! nvm ls default &>/dev/null || [[ "$(nvm ls default --no-colors 2>&1)" == *"N/A"* ]]; then
  echo "Installing default Node version (LTS)..."
  nvm install --lts
else
  echo "Default Node version already installed."
fi

###############################################################################
# uv (Astral) — Python toolchain
###############################################################################

if ! command -v uv &>/dev/null; then
  echo "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
else
  echo "uv already installed."
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
# Default shell — switch to apt-installed zsh
###############################################################################

ZSH_BIN="$(command -v zsh || true)"
if [[ -n "$ZSH_BIN" && "$SHELL" != "$ZSH_BIN" ]]; then
  echo "Switching default shell to zsh ($ZSH_BIN)..."
  chsh -s "$ZSH_BIN"
else
  echo "Default shell is already zsh."
fi

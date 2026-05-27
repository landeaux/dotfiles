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
# Binary name shims — Ubuntu's apt names some binaries differently than
# their upstream/macOS equivalents (fd-find -> fdfind, bat -> batcat).
# Symlink them into /usr/local/bin so the rest of the dotfiles (zsh
# config, plugins, etc.) can call the canonical names.
###############################################################################

if command -v fdfind &>/dev/null && [[ ! -e /usr/local/bin/fd ]]; then
  echo "Symlinking /usr/local/bin/fd -> $(command -v fdfind)"
  sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
fi

if command -v batcat &>/dev/null && [[ ! -e /usr/local/bin/bat ]]; then
  echo "Symlinking /usr/local/bin/bat -> $(command -v batcat)"
  sudo ln -sf "$(command -v batcat)" /usr/local/bin/bat
fi

###############################################################################
# Neovim — install from official GitHub release tarball (apt default is too
# old). Trusts HTTPS to github.com, matching the other curl-based installers
# below.
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
  NVIM_DOWNLOAD_URL="https://github.com/neovim/neovim/releases/latest/download/${NVIM_TARBALL}"
  NVIM_TMP="$(mktemp -d)"
  curl -fL "$NVIM_DOWNLOAD_URL" -o "${NVIM_TMP}/${NVIM_TARBALL}"
  sudo rm -rf "/opt/nvim-${NVIM_ARCH}"
  sudo tar -C /opt -xzf "${NVIM_TMP}/${NVIM_TARBALL}"
  sudo ln -sf "/opt/nvim-${NVIM_ARCH}/bin/nvim" /usr/local/bin/nvim
  rm -rf "$NVIM_TMP"
else
  echo "Neovim already installed."
fi

###############################################################################
# fzf — install from official GitHub release tarball. Apt's fzf on Ubuntu
# noble (0.44.1) predates `fzf --zsh` (added in 0.48), which the zsh config
# uses. jq is installed by the apt block above.
###############################################################################

if [[ ! -x /usr/local/bin/fzf ]]; then
  echo "Installing fzf from GitHub release tarball..."
  case "$(uname -m)" in
    x86_64) FZF_ARCH="linux_amd64" ;;
    aarch64 | arm64) FZF_ARCH="linux_arm64" ;;
    *)
      echo "Unsupported architecture for fzf tarball: $(uname -m)" >&2
      exit 1
      ;;
  esac
  FZF_VERSION="$(
    curl -fsSL https://api.github.com/repos/junegunn/fzf/releases/latest |
      jq -r '.tag_name' | sed 's/^v//'
  )"
  if [[ -z "$FZF_VERSION" ]]; then
    echo "Could not determine latest fzf version from GitHub API" >&2
    exit 1
  fi
  FZF_TARBALL="fzf-${FZF_VERSION}-${FZF_ARCH}.tar.gz"
  FZF_TMP="$(mktemp -d)"
  curl -fL "https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/${FZF_TARBALL}" \
    -o "${FZF_TMP}/${FZF_TARBALL}"
  sudo tar -C /usr/local/bin -xzf "${FZF_TMP}/${FZF_TARBALL}" fzf
  rm -rf "$FZF_TMP"
else
  echo "fzf already installed."
fi

###############################################################################
# ghq — install from official GitHub release zip. The zip contains docs and
# completions alongside the binary, so we extract specific members rather than
# unzipping the whole archive.
###############################################################################

if [[ ! -x /usr/local/bin/ghq ]]; then
  echo "Installing ghq from GitHub release zip..."
  case "$(uname -m)" in
    x86_64) GHQ_ARCH="amd64" ;;
    aarch64 | arm64) GHQ_ARCH="arm64" ;;
    *)
      echo "Unsupported architecture for ghq zip: $(uname -m)" >&2
      exit 1
      ;;
  esac
  GHQ_ZIP="ghq_linux_${GHQ_ARCH}.zip"
  GHQ_DOWNLOAD_URL="https://github.com/x-motemen/ghq/releases/latest/download/${GHQ_ZIP}"
  GHQ_TMP="$(mktemp -d)"
  curl -fL "$GHQ_DOWNLOAD_URL" -o "${GHQ_TMP}/${GHQ_ZIP}"
  sudo unzip -j -o "${GHQ_TMP}/${GHQ_ZIP}" "ghq_linux_${GHQ_ARCH}/ghq" -d /usr/local/bin
  sudo mkdir -p /usr/local/share/zsh/site-functions
  sudo unzip -j -o "${GHQ_TMP}/${GHQ_ZIP}" "ghq_linux_${GHQ_ARCH}/misc/zsh/_ghq" \
    -d /usr/local/share/zsh/site-functions
  rm -rf "$GHQ_TMP"
else
  echo "ghq already installed."
fi

###############################################################################
# tree-sitter CLI — needed by nvim-treesitter to compile parsers. Apt's
# tree-sitter-cli on Ubuntu noble lags significantly; install from GitHub
# release (gzipped single binary).
###############################################################################

if [[ ! -x /usr/local/bin/tree-sitter ]]; then
  echo "Installing tree-sitter CLI from GitHub release..."
  case "$(uname -m)" in
    x86_64) TS_ARCH="linux-x64" ;;
    aarch64 | arm64) TS_ARCH="linux-arm64" ;;
    *)
      echo "Unsupported architecture for tree-sitter: $(uname -m)" >&2
      exit 1
      ;;
  esac
  TS_GZ="tree-sitter-${TS_ARCH}.gz"
  TS_DOWNLOAD_URL="https://github.com/tree-sitter/tree-sitter/releases/latest/download/${TS_GZ}"
  TS_TMP="$(mktemp -d)"
  curl -fL "$TS_DOWNLOAD_URL" -o "${TS_TMP}/${TS_GZ}"
  gunzip "${TS_TMP}/${TS_GZ}"
  sudo install -m 0755 "${TS_TMP}/tree-sitter-${TS_ARCH}" /usr/local/bin/tree-sitter
  rm -rf "$TS_TMP"
else
  echo "tree-sitter already installed."
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

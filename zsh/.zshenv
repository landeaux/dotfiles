# Cargo/Rust
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Homebrew (needed early so command -v checks below find brew-installed binaries)
[[ -d /opt/homebrew/bin ]] && export PATH="/opt/homebrew/bin:$PATH"

# Core PATH
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# Go
[[ -d "$HOME/go/bin" ]] && export PATH="$PATH:$HOME/go/bin"

# Luarocks
[[ -d "$HOME/.luarocks" ]] && export PATH="$PATH:$HOME/.luarocks/bin"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Editor
if [[ "$(command -v nvim)" ]]; then
  export EDITOR='nvim'
elif [[ "$(command -v vim)" ]]; then
  export EDITOR='vim'
else
  export EDITOR='vi'
fi

# Python
export PYTHONDONTWRITEBYTECODE=1

# Docker
export DOCKER_DEFAULT_PLATFORM="linux/amd64"

# Poetry
export POETRY_VIRTUALENVS_IN_PROJECT=true

# Zettelkasten
export ZK_NOTEBOOK_DIR="$HOME/Notes"

# XDG (not set on stock macOS)
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Local overrides
[[ -f "$ZDOTDIR/.zshenv.local" ]] && source "$ZDOTDIR/.zshenv.local"

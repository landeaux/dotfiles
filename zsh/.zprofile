# Homebrew (must be first — other PATH additions depend on brew prefix)
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # GNU utilities (prefer GNU versions over macOS built-ins)
  _brew_prefix="$(brew --prefix)"
  export PATH="$_brew_prefix/opt/coreutils/libexec/gnubin:$PATH"
  export PATH="$_brew_prefix/opt/moreutils/libexec/gnubin:$PATH"
  export PATH="$_brew_prefix/opt/findutils/libexec/gnubin:$PATH"
  export PATH="$_brew_prefix/opt/gnu-sed/libexec/gnubin:$PATH"
  export PATH="$_brew_prefix/opt/ssh-copy-id/bin:$PATH"
  unset _brew_prefix
fi

# Local overrides
[[ -f "$ZDOTDIR/.zprofile.local" ]] && source "$ZDOTDIR/.zprofile.local"

# General
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias dust="du -sh * | sort -hr"
alias grep="grep --color=auto"
alias l="ls -lah"
alias la="ls -lAh"
alias ll="ls -lh"
alias ls="ls -F --color=auto"
alias md="mkdir -p"
alias path='echo -e ${PATH//:/\\n}'
alias pj="python -m json.tool"
alias rm="rm -i"

# sha256sum shim for macOS
if ! command -v sha256sum 1>/dev/null 2>&1; then
  alias sha256sum="shasum -a 256"
fi

# Ripgrep (OSC 8 hyperlinks — works with Ghostty, kitty, etc.)
alias rg="rg --hyperlink-format=file"

# Zsh config
alias zshconfig="nvim $ZDOTDIR"

# Tmux
if command -v tmux_workspace 1>/dev/null 2>&1; then
  alias tmw="tmux_workspace"
fi

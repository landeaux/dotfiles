# Initialize fzf key bindings and completion
eval "$(fzf --zsh)"

## catppuccin-latte
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
# --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
# --color=marker:#7287fd,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39 \
# --multi"
## catppuccin-frappe
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
# --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
# --color=marker:#babbf1,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
# --multi"
## catppuccin-macchiato
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
# --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
# --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
# --multi"
## catppuccin-mocha
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
# --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
# --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
# --multi"
# Kanagawa color theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#282727,bg:#181616,spinner:#dcd7ba,hl:#d27e99 \
--color=fg:#a3d4d5,header:#d27e99,info:#9cabca,pointer:#dcd7ba \
--color=marker:#a3d4d5,fg+:#a3d4d5,prompt:#9cabca,hl+:#d27e99 \
--multi"

# Use fd for file/directory search if available
if command -v fd 1>/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d'
fi

# Ctrl-G: pick and insert a git commit hash
fzf-commit-widget() {
  local commit
  commit=$(git log --oneline --color=always |
    fzf --ansi --preview 'git show --color=always {1}' |
    awk '{print $1}')
  LBUFFER+="$commit"
  zle reset-prompt
}
zle -N fzf-commit-widget
bindkey '^G' fzf-commit-widget

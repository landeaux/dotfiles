zmodload -i zsh/complist

# Docker CLI completions
fpath=($HOME/.docker/completions $fpath)

# Initialize completions (dump file outside ZDOTDIR to avoid polluting git repo)
mkdir -p "$XDG_CACHE_HOME/zsh"
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# Bash completion compatibility
autoload -U +X bashcompinit && bashcompinit

# Menu-driven completion
unsetopt menu_complete # do not autoselect the first completion entry
setopt auto_menu       # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

zstyle ':completion:*:*:*:*:*' menu select

# Case-insensitive, partial-word, and substring completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

# Colorize completions
zstyle ':completion:*' list-colors ''

# Process completion for kill
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"

# Use caching for expensive completions
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/compcache"

# Disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

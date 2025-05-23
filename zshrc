export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""
# ZSH_THEME="spaceship"
# SPACESHIP_VENV_SHOW=true

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  poetry
  git
  node
)

source $ZSH/oh-my-zsh.sh

# User configuration

unsetopt AUTO_CD # don't automatically change into directories

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# General
alias ls="ls -F --color=auto"
alias rm="rm -i"
alias prettifyjson="python -m json.tool"
alias dust="du -sh * | sort -hr"
alias path='echo -e ${PATH//:/\\n}' # Print each PATH entry on a separate line

if ! command -v sha256sum 1>/dev/null 2>&1; then
  alias sha256sum="shasum -a 256"
fi

# Ripgrep
alias rg="rg --hyperlink-format=kitty"

# Zsh
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"

# Tmux
if command -v tmux_workspace 1>/dev/null 2>&1; then
  alias tmw="tmux_workspace"
fi

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=($HOME/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

if [[ "$(command -v nvim)" ]]; then
  export EDITOR='nvim'
elif [[ "$(command -v vim)" ]]; then
  export EDITOR='vim'
else
  export EDITOR='vi'
fi

# Ensure containers are built using AMD64 architecture
export DOCKER_DEFAULT_PLATFORM="linux/amd64"

# Marker command palette (https://github.com/pindexis/marker)
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"
export MARKER_KEY_GET="\C-J"
export MARKER_KEY_NEXT_PLACEHOLDER="\C-/"

# stop python from writing pycs
export PYTHONDONTWRITEBYTECODE=1

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# pipenv
export PIPENV_VENV_IN_PROJECT=1              # make sure venv is always in the project dir
export PIPENV_DONT_LOAD_ENV=1                # don't let pipenv autoload env... we have direnv for this
eval "$(_PIPENV_COMPLETE=zsh_source pipenv)" # set up magic shell completion

# poetry
export POETRY_VIRTUALENVS_IN_PROJECT=true

# fzf
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
## Kanagawa
export FZF_DEFAULT_OPTS=" \
--color=bg+:#282727,bg:#181616,spinner:#dcd7ba,hl:#d27e99 \
--color=fg:#a3d4d5,header:#d27e99,info:#9cabca,pointer:#dcd7ba \
--color=marker:#a3d4d5,fg+:#a3d4d5,prompt:#9cabca,hl+:#d27e99 \
--multi"
if command -v fd 1>/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d'
fi

# nvm config
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  if [ -f .nvmrc ]; then
    nvm use
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# add Go and Go package binaries to PATH
go_path="/usr/local/go/bin"
go_pkg_path="${HOME}/go/bin"
[ -d "${go_path}" ] && export PATH="${PATH}:${go_path}"
[ -d "${go_pkg_path}" ] && export PATH="${PATH}:${go_pkg_path}"

# add luarocks binaries to PATH
[ -d "${HOME}/.luarocks" ] && export PATH="${PATH}:${HOME}/.luarocks/bin"

# direnv hook
if command -v direnv 1>/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# zk
export ZK_NOTEBOOK_DIR="$HOME/Notes"

# bat
if command -v bat 1>/dev/null 2>&1; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# source our functions
if [ -f ~/.functions ]; then
  source ~/.functions
fi

if command -v brew 1>/dev/null 2>&1; then
  export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
  export PATH="$(brew --prefix moreutils)/libexec/gnubin:$PATH"
  export PATH="$(brew --prefix findutils)/libexec/gnubin:$PATH"
  export PATH="$(brew --prefix gnu-sed)/libexec/gnubin:$PATH"
  export PATH="$(brew --prefix ssh-copy-id)/bin:$PATH"
fi

# initialize starship prompt
eval "$(starship init zsh)"

###############################################################################

# allow overrides (NOTE: This must stay at the bottom of the file!)
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

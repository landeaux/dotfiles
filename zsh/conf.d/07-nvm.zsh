export NVM_DIR="$HOME/.nvm"

if command -v brew 1>/dev/null 2>&1; then
  local _brew_prefix
  _brew_prefix="$(brew --prefix)"
  [ -s "$_brew_prefix/opt/nvm/nvm.sh" ] && \. "$_brew_prefix/opt/nvm/nvm.sh"
  [ -s "$_brew_prefix/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$_brew_prefix/opt/nvm/etc/bash_completion.d/nvm"
  unset _brew_prefix
fi

# Auto-switch Node versions when entering a directory with .nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  if [ -f .nvmrc ]; then
    nvm use
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

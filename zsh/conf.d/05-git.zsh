# Helper functions (from oh-my-zsh, needed by aliases below)
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}; do
    if command git show-ref -q --verify "$ref"; then
      echo "${ref:t}"
      return 0
    fi
  done
  echo master
  return 1
}

function git_develop_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in dev devel develop development; do
    if command git show-ref -q --verify "refs/heads/$branch"; then
      echo "$branch"
      return 0
    fi
  done
  echo develop
  return 1
}

function git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2>/dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return # no git repo
    ref=$(command git rev-parse --short HEAD 2>/dev/null) || return
  fi
  echo "${ref#refs/heads/}"
}

# Aliases (curated from oh-my-zsh git plugin based on shell history)
alias ga='git add'
alias gb='git branch'
alias gbd='git branch --delete'
alias gc='git commit --verbose'
alias gco='git checkout'
alias gcm='git checkout $(git_main_branch)'
alias gcd='git checkout $(git_develop_branch)'
alias gd='git diff'
alias gds='git diff --staged'
alias gf='git fetch'
alias gl='git pull'
alias glog='git log --oneline --decorate --graph'
alias gm='git merge'
alias gp='git push'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gst='git status'

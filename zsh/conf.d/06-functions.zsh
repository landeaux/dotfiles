fzb() {
  local branch
  branch=$(git branch --all --sort=-committerdate --format='%(refname:short)' |
    grep -v '^origin/HEAD' |
    fzf --preview 'git log --oneline --color=always {} | head -20')
  [ -z "$branch" ] && return
  git switch "${branch#origin/}"
}

fzclean() {
  local branches
  branches=$(git branch --merged |
    grep -vE '^\*|^\s*(main|master|develop)\s*$' |
    sed 's/^[[:space:]]*//')
  if [ -z "$branches" ]; then
    echo "No merged branches to clean up."
    return
  fi
  echo "$branches" |
    fzf --multi --preview 'git log --oneline --color=always {} | head -10' |
    xargs -r git branch -d
}

fzstash() {
  local stash
  stash=$(git stash list |
    fzf --preview 'echo {} | cut -d: -f1 | xargs git stash show -p --color=always' |
    cut -d: -f1)
  [ -z "$stash" ] && return
  local action
  action=$(printf "apply\npop\ndrop\nshow" |
    fzf --prompt "Action for $stash> ")
  [ -n "$action" ] && git stash "$action" "$stash"
}

fzwt() {
  case "${1:-}" in
  add)
    local branch="${2:?Usage: fzwt add <branch>}"
    local repo
    repo=$(basename "$(git rev-parse --show-toplevel)")
    local dest="../${repo}.${branch}"
    git worktree add "$dest" -b "$branch" 2>/dev/null ||
      git worktree add "$dest" "$branch"
    cd "$dest" || return
    ;;
  rm)
    local dir
    dir=$(git worktree list |
      fzf --preview 'git log --oneline --color=always -10 {2}' |
      awk '{print $1}')
    [ -n "$dir" ] && git worktree remove "$dir"
    ;;
  *)
    local dir
    dir=$(git worktree list |
      fzf --preview 'git log --oneline --color=always -10 {2}' |
      awk '{print $1}')
    [ -n "$dir" ] && cd "$dir" || return
    ;;
  esac
}

tre() {
  tree -aC --gitignore -I '.git' --dirsfirst "$@" | less -FRX
}

yeet() {
  if [ ! "$1" ]; then
    echo "Usage: yeet process_name"
  elif killall "$1"; then
    echo
    echo " (╯°□°）╯︵$(echo "$1" | flip)"
    echo
  fi
}

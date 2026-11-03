# Zsh config

`ZDOTDIR=$HOME/.config/zsh`, linked from `zsh/`.

- `zsh/conf.d/` files are sourced in numeric order (`01-options.zsh` before `02-completion.zsh`). A new file needs a
  number that places it after everything it depends on.
- New shell functions go in `zsh/conf.d/07-functions.zsh`.

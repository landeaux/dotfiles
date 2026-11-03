# CLAUDE.md

Personal dotfiles managed with [dotbot](https://github.com/anishathalye/dotbot). Files live in this repo and are
symlinked into place (home dir, `~/.config/`, `~/.claude/`) by `install.conf.yaml`.

## Commands

- `./install` — dotbot: create/update symlinks
- `./scripts/bootstrap.sh` — full setup: prerequisites → tools → dotfiles → macOS defaults

## Rules

- `install.conf.yaml` is the source of truth for what links where. Edit files at their repo paths, never at the
  symlink targets.
- New config goes at XDG paths (`~/.config/...`) where the tool supports it.
- Machine-specific config goes in gitignored `.local` files (`.zshenv.local`, `.zshrc.local`, `Brewfile.local`).
- Scripts in `scripts/` use `set -e` and are idempotent.

## Reference

- [Zsh config](docs/zsh.md) — read before editing anything under `zsh/`.
- [Neovim config](docs/nvim.md) — read before editing or running anything under `nvim/`.

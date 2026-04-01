# CLAUDE.md

## Commands

- `./install` — Run dotbot to create/update symlinks (defined in `install.conf.yaml`)
- `./scripts/bootstrap.sh` — Full setup: prerequisites → tools → dotfiles → macOS defaults
- Individual scripts can be run standalone (see `scripts/`)

## Architecture

This is a dotfiles repo managed with [dotbot](https://github.com/anishathalye/dotbot). Files live here and are symlinked
to their target locations (home dir, `~/.config/`, etc.) via `install.conf.yaml`.

Key directories:

- `zsh/` — Modular zsh config: `conf.d/` files sourced in numbered order, `functions/` autoloaded
- `nvim/` — Neovim config (vim.pack, plugins in `lua/my/plugins/`)
- `claude/` — Claude Code global config (symlinked to `~/.claude/`): `CLAUDE.md`, `settings.json`, `hooks/`
- `scripts/` — Bootstrap and utility scripts (idempotent, safe to re-run)
- `bin/` — User scripts symlinked to `~/bin/`

## Key Patterns

- **Symlinks, not copies.** `install.conf.yaml` is the source of truth for what gets linked where. Edit files at their
  repo paths, not the symlink targets.
- **Numbered conf.d ordering.** Zsh files in `conf.d/` are sourced numerically (`01-options.zsh` before
  `02-completion.zsh`). Ordering matters — new files need an appropriate number.
- **Local overrides.** Machine-specific config goes in `.local` files (`.zshenv.local`, `.zshrc.local`,
  `Brewfile.local`) which are gitignored.
- **Hook parity.** Claude hooks in `claude/hooks/` mirror nvim's conform.nvim (format) and none-ls (lint) configs. When
  updating one, update the other.
- **Autoloaded functions.** New zsh functions go in `zsh/functions/` as individual files and must be registered in
  `.zshrc`'s `autoload -Uz` line.
- **Neovim headless commands.** Always use `nvim --headless` when running nvim non-interactively (benchmarks, health checks, etc.) or it will hang waiting for a terminal.

## Conventions

- Conventional commits: `feat(scope):`, `fix:`, `refactor:`, `chore:`, `docs:`
- Scripts use `set -e` and are idempotent
- XDG-compliant paths where possible (`ZDOTDIR=$HOME/.config/zsh`)

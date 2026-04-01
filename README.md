# Dotfiles

Personal dotfiles managed with [dotbot](https://github.com/anishathalye/dotbot).

## Fresh Machine Setup

On a brand-new Mac:

```bash
curl -fsSL https://raw.githubusercontent.com/landeaux/dotfiles/main/scripts/seed.sh | bash
```

This will:

1. Install Xcode Command Line Tools
2. Install Homebrew
3. Clone this repo to `~/dotfiles`
4. Run the full bootstrap (tools, dotfiles, macOS defaults)

## Updating an Existing Machine

From the dotfiles directory:

```bash
./scripts/bootstrap.sh
```

This re-runs the full setup and is safe to run repeatedly (all scripts are idempotent).

## Running Individual Scripts

Each script can be run independently:

| Script                      | Purpose                                  |
| --------------------------- | ---------------------------------------- |
| `scripts/prerequisites.sh`  | Xcode CLI tools + Homebrew               |
| `scripts/install_tools.sh`  | Brew packages, rustup, Claude Code, Node |
| `./install`                 | Dotbot symlinks + shell commands         |
| `scripts/macos_defaults.sh` | macOS system preferences                 |

## macOS Defaults

The `scripts/macos_defaults.sh` script configures macOS system preferences. To explore available defaults:

**Dump current settings for a specific domain:**

```bash
defaults read com.apple.dock
```

**List all defaults domains:**

```bash
defaults domains
```

**Find defaults for an application** (replace `appname` with the app's domain):

```bash
defaults read com.apple.appname
```

**Common domains to explore:**

- `com.apple.dock` — Dock settings
- `com.apple.finder` — Finder preferences
- `com.apple.screensaver` — Screensaver options
- `com.apple.menuextra.battery` — Battery display
- `NSGlobalDomain` — System-wide settings

Add new defaults to `scripts/macos_defaults.sh` following the existing pattern.

## Managing Neovim Plugins

Plugins are managed with `vim.pack` (Neovim 0.12 built-in). All plugins are declared in
`nvim/lua/my/pluginsInit.lua`.

**Update all plugins:**

```lua
vim.pack.update()
```

Opens a confirmation buffer — `:write` to apply, `:quit` to discard, `:restart` to reload.

**Install a new plugin:** add it to the `vim.pack.add({...})` call in `pluginsInit.lua` along with a
`require()` call for its setup module, then restart Neovim.

**Remove a plugin:**

1. Delete it from `vim.pack.add()` and its `require()` call in `pluginsInit.lua`
2. Delete it from disk:

```lua
vim.pack.del({ "plugin-name" })
```

**Rollback a bad update:**

```bash
git checkout HEAD -- nvim/nvim-pack-lock.json
```

Then in Neovim:

```lua
vim.pack.update(nil, { target = "lockfile" })
```

**Check what's installed:**

```lua
vim.print(vim.pack.get())
```

Or `vim.pack.update(nil, { offline = true })` for a visual overview without downloading anything.

## Machine-Specific Packages

Add a `Brewfile.local` in the repo root for packages specific to one machine. It is automatically included by the
Brewfile and ignored by git.

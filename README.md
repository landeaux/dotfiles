# Dotfiles

Personal dotfiles managed with [dotbot](https://github.com/anishathalye/dotbot).

## Fresh Machine Setup

On a brand-new Mac, download and inspect the seed script, then run it:

    curl -fsSL https://raw.githubusercontent.com/landeaux/dotfiles/main/scripts/seed.sh -o /tmp/seed.sh
    less /tmp/seed.sh
    bash /tmp/seed.sh

This will:

1. Install Xcode Command Line Tools
2. Install Homebrew
3. Clone this repo to `~/dotfiles`
4. Run the full bootstrap (tools, dotfiles, macOS defaults)

## Updating an Existing Machine

From the dotfiles directory:

    ./scripts/bootstrap.sh

This re-runs the full setup and is safe to run repeatedly (all scripts are idempotent).

## Running Individual Scripts

Each script can be run independently:

| Script                      | Purpose                                              |
| --------------------------- | ---------------------------------------------------- |
| `scripts/prerequisites.sh`  | Xcode CLI tools + Homebrew                           |
| `scripts/install_tools.sh`  | Brew packages + oh-my-zsh, rustup, Claude Code, Node |
| `./install`                 | Dotbot symlinks + shell commands                     |
| `scripts/macos_defaults.sh` | macOS system preferences                             |

## macOS Defaults

The `scripts/macos_defaults.sh` script configures macOS system preferences. To explore available defaults:

**Dump current settings for a specific domain:**

    defaults read com.apple.dock

**List all defaults domains:**

    defaults domains

**Find defaults for an application** (replace `appname` with the app's domain):

    defaults read com.apple.appname

**Common domains to explore:**

- `com.apple.dock` — Dock settings
- `com.apple.finder` — Finder preferences
- `com.apple.screensaver` — Screensaver options
- `com.apple.menuextra.battery` — Battery display
- `NSGlobalDomain` — System-wide settings

Add new defaults to `scripts/macos_defaults.sh` following the existing pattern.

## Machine-Specific Packages

Add a `Brewfile.local` in the repo root for packages specific to one machine. It is automatically included by the
Brewfile and ignored by git.

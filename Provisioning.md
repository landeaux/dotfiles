# Provisioning

## Install

- [✓] Nerd fonts (SourceCodePro)
- [✓] Install zsh (already installed on macOS)
- [✓] oh-my-zsh (using curl)
- [✓] oh-my-zsh spaceship theme (using curl, depends on Nerd fonts)
- [✓] kitty (using curl)
- [✓] tmux (using brew)
- [✓] pyenv (using curl)
- [✓] pipenv (requires pip)
- [✓] nvm (provides npm, node)
- [✓] go (dpkg download)
- [✓] shfmt (depends on go)
- [✓] shellcheck (macOS: brew, Linux: ???)
- [✓] markdownlint-cli (depends on npm)
- [✓] prettierd (depends on npm, required by null_ls)
- [✓] eslint_d (depends on npm, required by null_ls)
- [✓] luarocks (using brew)
- [✓] luacheck (depends on luarocks)
- [✓] stylua (depends on cargo)
- [✓] neovim (macOS: brew, Linux: from source)
- [✓] My dotfiles (requires git)

## Misc

- see if `exec "$SHELL"` works okay in scripts for re-sourcing .zshrc

## Checklist

- [ ] Generate ssh keys and add to GitHub account
- [ ] Clone dotfiles
- [ ] Install fonts
- [ ] Install zsh
- [ ] Install oh-my-zsh
- [ ] Install oh-my-zsh theme
- [ ] Install kitty
- [ ] Install tmux
- [ ] Install pyenv
- [ ] Install pipenv
- [ ] Install nvm
- [ ] Install go
- [ ] Install shfmt
- [ ] Install shellcheck
- [ ] Install markdownlint-cli
- [ ] Install prettierd
- [ ] Install eslint_d
- [ ] Install luarocks
- [ ] Install luacheck
- [ ] Install stylua
- [ ] Install neovim
- [ ] Install dotfiles
- [ ] Configure spell functionality for neovim
- [ ] Install docker

### Clone dotfiles

1. Open terminal
2. Go to the home directory
3. Create ~/Development directory
4. Go into ~/Development directory
5. Clone dotfiles
6. Go into ~/Development/dotfiles directory

### Install fonts

1. Install the fonts in the ~/Development/dotfiles directory

### Install zsh

NOTE: skip if on macOS (zsh is already installed)

1. Install zsh using the apt package manager:

   ```bash
   sudo apt install zsh
   ```

### Install Oh My Zsh

[Oh! My Zsh](https://ohmyz.sh/#install)

1. Download and run the install-script:

   ```bash
   sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

### Install Spaceship theme for Oh My Zsh

[Spaceship Prompt](https://github.com/spaceship-prompt/spaceship-prompt/)

1. Clone the repo:

   ```bash
   git clone https://github.com/spaceship-prompt/spaceship-prompt.git \
     "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
   ```

2. Symlink spaceship.zsh-theme to your oh-my-zsh custom themes directory:

   ```bash
   ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
   ```

### Install kitty terminal

[kitty](https://sw.kovidgoyal.net/kitty/)

1. Download and install the pre-built binaries:

   ```bash
   curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
   ```

### Install tmux

1. Install tmux via a package manager:

   ```bash
   # macOS
   brew install tmux

   # Debian/Ubuntu
   apt install tmux
   ```

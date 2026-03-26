#!/usr/bin/env bash
set -e

if [[ "$(uname)" != "Darwin" ]]; then
  echo "Skipping macOS defaults (not on macOS)."
  exit 0
fi

echo "Applying macOS defaults..."

###############################################################################
# General UI/UX
###############################################################################

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

###############################################################################
# Keyboard
###############################################################################

# Enable full keyboard access for all controls (e.g., Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2

# Set short delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15

###############################################################################
# Trackpad
###############################################################################

# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

###############################################################################
# Finder
###############################################################################

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

###############################################################################
# Dock
###############################################################################

# Set Dock icon size
defaults write com.apple.dock tilesize -int 48

# Minimize windows using scale effect
defaults write com.apple.dock mineffect -string "scale"

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

###############################################################################
# Screenshots
###############################################################################

# Save screenshots to ~/Screenshots
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"

# Save screenshots as PNG
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Restart affected applications
# Note: if you add new domains, check whether they require a restart of a
# specific app and add it here. NSGlobalDomain settings take effect on next
# app launch; trackpad settings require a logout/restart.
###############################################################################

echo "Restarting affected applications..."
for app in "Dock" "Finder" "SystemUIServer"; do
  killall "$app" &>/dev/null || true
done

echo "macOS defaults applied. Some changes may require a logout/restart."

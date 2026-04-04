#!/usr/bin/env bash
set -e

QMK_HOME="$HOME/qmk_firmware"
QMK_FORK="landeaux"
QMK_BRANCH="crkbd_rev1_landeaux"

if [[ ! -d "$QMK_HOME" ]]; then
  echo "Cloning QMK firmware fork and running setup..."
  qmk setup "$QMK_FORK" -H "$QMK_HOME" --branch "$QMK_BRANCH" -y
else
  echo "QMK firmware already cloned."

  # Ensure the correct branch is checked out
  CURRENT_BRANCH="$(git -C "$QMK_HOME" branch --show-current)"
  if [[ "$CURRENT_BRANCH" != "$QMK_BRANCH" ]]; then
    echo "Switching to branch $QMK_BRANCH..."
    git -C "$QMK_HOME" checkout "$QMK_BRANCH"
  fi

  echo "Running QMK setup (submodules + dependencies)..."
  qmk setup -H "$QMK_HOME" -y
fi

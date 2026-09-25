#!/usr/bin/env bash

set -euo pipefail

GITHUB_REPO=https://github.com/chilimangoes/dotfiles.git
APP_DIR="$HOME/dotfiles"

if [[ ! -d "$APP_DIR" ]]; then
    git clone "$GITHUB_REPO" "$APP_DIR"
else
    echo "Updating dotfiles"
    git -C "$APP_DIR" pull --ff-only
fi

link_dotfile() {
    local source=$1 destination=$2
    if [[ -e "$destination" || -L "$destination" ]]; then
        mv "$destination" "$destination.backup-$(date +%Y%m%d%H%M%S)"
    fi
    ln -s "$source" "$destination"
}

link_dotfile "$APP_DIR/vim/.vimrc" "$HOME/.vimrc"
link_dotfile "$APP_DIR/git/.gitconfig-aliases" "$HOME/.gitconfig-aliases"
git config --global include.path "$HOME/.gitconfig-aliases"

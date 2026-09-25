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
link_dotfile "$APP_DIR/bash/.bash_aliases" "$HOME/.bash_aliases"
git config --global include.path "$HOME/.gitconfig-aliases"

ensure_bash_aliases_loaded() {
    local bashrc="$HOME/.bashrc"
    local marker="# Load dotfiles Bash helpers."

    if [[ ! -f "$bashrc" ]]; then
        touch "$bashrc"
    fi

    if ! grep -Fqx "$marker" "$bashrc"; then
        cat >> "$bashrc" <<'EOF'

# Load dotfiles Bash helpers.
if [[ -f "$HOME/.bash_aliases" ]]; then
    source "$HOME/.bash_aliases"
fi
EOF
    fi
}

ensure_bash_aliases_loaded

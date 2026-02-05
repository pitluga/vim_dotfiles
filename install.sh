#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

backup_if_exists() {
    local target="$1"
    if [ -e "$target" ] || [ -L "$target" ]; then
        local backup="${target}.backup.$(date +%Y%m%d%H%M%S)"
        log_warn "Backing up existing $target to $backup"
        mv "$target" "$backup"
    fi
}

create_symlink() {
    local source="$1"
    local target="$2"

    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
        log_info "Symlink already exists: $target -> $source"
        return
    fi

    backup_if_exists "$target"
    ln -s "$source" "$target"
    log_info "Created symlink: $target -> $source"
}

# Vim configuration
log_info "Setting up Vim configuration..."
create_symlink "$DOTFILES_DIR/vimrc" "$HOME/.vimrc"
create_symlink "$DOTFILES_DIR/vim" "$HOME/.vim"

# Neovim configuration
log_info "Setting up Neovim configuration..."
mkdir -p "$HOME/.config"
create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

log_info "Installation complete!"

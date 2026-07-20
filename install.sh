#!/usr/bin/env bash

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Starting Neovim Setup & Installation ===${NC}\n"

mkdir -p "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

# 1. Install Neovim standalone binary (without requiring Homebrew)
if ! command -v nvim &>/dev/null; then
    echo -e "${YELLOW}[1/4] Neovim not found. Installing standalone pre-built binary...${NC}"
    ARCH="$(uname -m)"
    OS="$(uname -s)"
    
    if [[ "$OS" == "Darwin" ]]; then
        if [[ "$ARCH" == "arm64" ]]; then
            URL="https://github.com/neovim/neovim/releases/latest/download/nvim-macos-arm64.tar.gz"
        else
            URL="https://github.com/neovim/neovim/releases/latest/download/nvim-macos-x86_64.tar.gz"
        fi
    elif [[ "$OS" == "Linux" ]]; then
        if [[ "$ARCH" == "aarch64" ]]; then
            URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz"
        else
            URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
        fi
    else
        echo -e "${RED}Unsupported OS: $OS${NC}"
        exit 1
    fi
    
    curl -fsSL "$URL" -o /tmp/nvim.tar.gz
    tar -xzf /tmp/nvim.tar.gz -C "$HOME/.local" --strip-components=1
    rm -f /tmp/nvim.tar.gz
    echo -e "${GREEN}Neovim installed successfully to $HOME/.local/bin/nvim${NC}"
else
    echo -e "${GREEN}[1/4] Neovim is already installed: $(command -v nvim)${NC}"
fi

# 2. Backup old Neovim config if exists
if [ -d "$HOME/.config/nvim" ] && [ ! -d "$HOME/.config/nvim/.git" ]; then
    echo -e "${YELLOW}[2/4] Backing up existing Neovim configuration...${NC}"
    BACKUP_DIR="$HOME/.config/nvim.bak.$(date +%Y%m%d_%H%M%S)"
    mv "$HOME/.config/nvim" "$BACKUP_DIR"
    echo -e "${GREEN}Old config backed up to: $BACKUP_DIR${NC}"
fi

# 3. Clone or update nvim-config repository
echo -e "${YELLOW}[3/4] Setting up Neovim configuration...${NC}"
mkdir -p "$HOME/.config"
if [ ! -d "$HOME/.config/nvim" ]; then
    git clone https://github.com/Knotty123230/nvim-config.git "$HOME/.config/nvim"
else
    echo -e "${GREEN}Neovim repo already cloned at $HOME/.config/nvim${NC}"
fi

# 4. Install plugins and LSP servers via Lazy and Mason
echo -e "${YELLOW}[4/4] Syncing Lazy plugins and setting up LSPs...${NC}"
"$HOME/.local/bin/nvim" --headless "+Lazy! sync" +qa || nvim --headless "+Lazy! sync" +qa

echo -e "\n${GREEN}=== Setup completed successfully! ===${NC}"
echo -e "${BLUE}Run 'nvim' in your terminal to start.${NC}"

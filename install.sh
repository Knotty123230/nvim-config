#!/usr/bin/env bash

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Starting Neovim Setup & Installation ===${NC}\n"

# 1. Detect OS and install base dependencies
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo -e "${YELLOW}[1/4] Detecting macOS environment...${NC}"
    if ! command -v brew &>/dev/null; then
        echo -e "${YELLOW}Homebrew not found. Installing Homebrew...${NC}"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    echo -e "${GREEN}Installing dependencies via Homebrew (neovim, git, ripgrep, fd, node, openjdk@21)...${NC}"
    brew install --force-bottle neovim git ripgrep fd node openjdk@21 || true
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo -e "${YELLOW}[1/4] Detecting Linux environment...${NC}"
    if command -v apt-get &>/dev/null; then
        sudo apt-get update
        sudo apt-get install -y neovim git ripgrep fd-find nodejs npm openjdk-21-jdk || true
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y neovim git ripgrep fd-find nodejs java-21-openjdk || true
    fi
fi

# 2. Backup old Neovim config if exists
if [ -d "$HOME/.config/nvim" ]; then
    echo -e "${YELLOW}[2/4] Backing up existing Neovim configuration...${NC}"
    BACKUP_DIR="$HOME/.config/nvim.bak.$(date +%Y%m%d_%H%M%S)"
    mv "$HOME/.config/nvim" "$BACKUP_DIR"
    echo -e "${GREEN}Old config backed up to: $BACKUP_DIR${NC}"
fi

# 3. Clone nvim-config repository
echo -e "${YELLOW}[3/4] Cloning Neovim configuration...${NC}"
mkdir -p "$HOME/.config"
git clone https://github.com/Knotty123230/nvim-config.git "$HOME/.config/nvim"

# 4. Install plugins and LSP servers via Lazy and Mason
echo -e "${YELLOW}[4/4] Syncing Lazy plugins and setting up LSPs...${NC}"
nvim --headless "+Lazy! sync" +qa

echo -e "\n${GREEN}=== Setup completed successfully! ===${NC}"
echo -e "${BLUE}Run 'nvim' in your terminal to start.${NC}"

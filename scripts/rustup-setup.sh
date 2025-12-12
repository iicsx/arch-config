#!/usr/bin/env bash
# Set up Cargo using Rustup

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Setting up Cargo...${NC}"
echo ""

# Check if rustup is installed
if ! command -v rustup &> /dev/null; then
    echo -e "${YELLOW}Rustup not found. Installing Rustup...${NC}"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

# Ensure the stable toolchain is installed
echo -e "${BLUE}Ensuring stable toolchain is installed...${NC}"
rustup install stable
rustup default stable 
echo -e "${GREEN}Stable toolchain is set as default.${NC}"

# Add common components
# For example, adding clippy and rustfmt
echo -e "${BLUE}Adding common components (clippy, rustfmt)...${NC}"
rustup component add clippy
rustup component add rustfmt
echo -e "${GREEN}Components added successfully.${NC}"

echo ""
echo -e "${GREEN}Cargo configuration complete!${NC}"
echo ""

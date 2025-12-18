#!/usr/bin/env bash
# Enable Ly display manager

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Enabling Ly display manager...${NC}"
echo ""

# Check if we have root privileges
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Error: This script must be run with sudo${NC}" >&2
  exit 1
fi

# Enable Ly
if systemctl is-enabled ly@tty2.service &>/dev/null; then
  echo -e "${YELLOW}Ly is already enabled${NC}"
else
  echo -e "${BLUE}Enabling Ly service...${NC}"
  systemctl enable ly@tty2.service
  echo -e "${GREEN}Ly enabled${NC}"
fi

echo ""
echo -e "${GREEN}Ly configuration complete!${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "  - Reboot your system to use Ly"
echo "  - Or manually start Ly: sudo systemctl start ly.service"
echo ""


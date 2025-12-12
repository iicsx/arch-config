#!/usr/bin/env bash
# Sync wallpapers

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

TARGET_USER="${SUDO_USER:-$USER}"
TARGET_HOME="/home/${TARGET_USER}"
CONFIG_DIR="${TARGET_HOME}/.config"
ARCH_CONFIG_DIR="${ARCH_CONFIG_DIR:-${TARGET_HOME}/.config/arch-config}"
WALLPAPER_DIR="${ARCH_CONFIG_DIR}/wallpapers"
TARGET_DIR="${TARGET_HOME}/Pictures/Wallpapers"

echo -e "${BLUE}Putting wallpapers into ${TARGET_DIR}...${NC}"
echo ""

for file in $(find ${WALLPAPER_DIR} -maxdepth 1 -type f -not -path ${WALLPAPER_DIR} -printf "%P\n"); do 
  echo -e "${BLUE}Copying '${file}' to destination...${NC}"

  cp "${WALLPAPER_DIR}/${file}" "${TARGET_DIR}/${file}"
done

echo ""
echo -e "${GREEN}Wallpaper settings updated!${NC}"
echo ""

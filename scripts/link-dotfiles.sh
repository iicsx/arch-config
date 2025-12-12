#!/usr/bin/env bash
# Post-install hook for dotfiles
# Dotfiles are now handled by dcli's symlink system
# This script only handles additional configuration that can't be symlinked

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Determine the user (handles both sudo and non-sudo cases)
TARGET_USER="${SUDO_USER:-$USER}"
TARGET_HOME="/home/${TARGET_USER}"
CONFIG_DIR="${TARGET_HOME}/.config"
ARCH_CONFIG_DIR="${ARCH_CONFIG_DIR:-${TARGET_HOME}/.config/arch-config}"
DOTFILES_DIR="${ARCH_CONFIG_DIR}/dotfiles"
BACKUP_DIR="${CONFIG_DIR}/.backup.$(date +%Y%m%d%H%M%S)"

echo -e "${BLUE}Configuring Dotfiles...${NC}"
echo ""
echo -e "${YELLOW}Note: Dotfiles are now managed via symlinks by dcli${NC}"
echo ""

# Ensure the arch-config directory exists
if [ ! -d "${ARCH_CONFIG_DIR}" ]; then
    echo -e "${RED}Error: arch-config directory not found at ${ARCH_CONFIG_DIR}${NC}"
    exit 1
fi

for dir in $(find ${DOTFILES_DIR} -maxdepth 1 -type d -not -path ${DOTFILES_DIR} -printf "%P\n"); do
    # Back up existing files
    if [ -d "${CONFIG_DIR}/${dir}" ] && [ ! -h "${CONFIG_DIR}/${dir}" ]; then # if the directory exists and is not a symlink
        echo -e "${YELLOW}Backing up existing config at ${BACKUP_DIR}/${dir}...${NC}"
	      mkdir -p "${BACKUP_DIR}/${dir}"
        mv "${CONFIG_DIR}/${dir}" "${BACKUP_DIR}/${dir}"
        echo -e "${GREEN}Backup created at ${BACKUP_DIR}/${dir}${NC}"
    fi

    if [ ! -h "${CONFIG_DIR}/${dir}" ]; then
        echo -e "${GREEN}Linked ${dir} to ${CONFIG_DIR}/${dir}${NC}"
        ln -s "${DOTFILES_DIR}/${dir}" "${CONFIG_DIR}"
    else
	echo -e "${YELLOW}${dir} is already linked, skipping...${NC}"
    fi
done

for file in $(find ${DOTFILES_DIR} -maxdepth 1 -type f -printf "%P\n"); do
    # Back up existing files
    if [ -f "${CONFIG_DIR}/${file}" ] && [ ! -h "${CONFIG_DIR}/${file}" ]; then # if the file exists and is not a symlink
        echo -e "${YELLOW}Backing up existing config at ${BACKUP_DIR}/${file}...${NC}"
        mkdir -p "${BACKUP_DIR}"
        mv "${CONFIG_DIR}/${file}" "${BACKUP_DIR}/${file}"
        echo -e "${GREEN}Backup created at ${BACKUP_DIR}/${file}${NC}"
    fi

    if [ ! -h "${CONFIG_DIR}/${file}" ]; then
        echo -e "${GREEN}Linked ${file} to ${CONFIG_DIR}/${file}${NC}"
        ln -s "${DOTFILES_DIR}/${file}" "${CONFIG_DIR}"
    else
  echo -e "${YELLOW}${file} is already linked, skipping...${NC}"
    fi
done

# If the invoking user is root, update the symlink permissions to user 
if [ "$EUID" -eq 0 ]; then
  chown -R "${TARGET_USER}:${TARGET_USER}" "${CONFIG_DIR}"
fi

echo ""
echo -e "${BLUE}Dotfiles are symlinked from ${DOTFILES_DIR}${NC}"
echo ""


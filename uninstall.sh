#!/usr/bin/env bash

set -e

# Determine OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
else
    echo "Unsupported OS. This script is designed for macOS and Linux."
    exit 1
fi

# Set install directory
if [ "$OS" == "macos" ]; then
    INSTALL_DIR="/usr/local/bin"
    CONFIG_DIR="$HOME/Library/Application Support/menu-script"
else
    INSTALL_DIR="/usr/local/bin"
    CONFIG_DIR="$HOME/.config/menu-script"
fi

# Remove main script
rm -f "$INSTALL_DIR/menu-script"

# Remove configuration
rm -rf "$CONFIG_DIR"

echo "Uninstallation completed. The menu-script has been removed."
echo "Your scripts in $HOME/scripts have not been removed."
echo "If you wish to remove them as well, please do so manually."
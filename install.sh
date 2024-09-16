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

# Function to check if we have write permission to a directory
check_write_permission() {
    if [ -w "$1" ]; then
        return 0
    else
        return 1
    fi
}

# Function to run a command with sudo if needed
run_with_sudo_if_needed() {
    if check_write_permission "$INSTALL_DIR"; then
        "$@"
    else
        echo "Elevated privileges required for installation in $INSTALL_DIR"
        sudo "$@"
    fi
}

# Source the default configuration
source default_config.sh

# Function to prompt for configuration changes
prompt_config() {
    local var_name="$1"
    local current_value="${!var_name}"
    local prompt_text="$2"
    
    read -p "$prompt_text [$current_value]: " new_value
    if [ -n "$new_value" ]; then
        eval "$var_name=\"$new_value\""
    fi
}


# Prompt user for configuration changes
echo "Current configuration:"
echo "INSTALL_DIR: $INSTALL_DIR"
echo "SCRIPTS_DIR: $SCRIPTS_DIR"
echo "CONFIG_DIR: $CONFIG_DIR"
echo

read -p "Do you want to customize these settings? (y/n) " customize
if [[ "$customize" == "y" ]]; then
    prompt_config INSTALL_DIR "Enter installation directory for the main script"
    prompt_config SCRIPTS_DIR "Enter directory for user scripts"
    prompt_config CONFIG_DIR "Enter directory for configuration files"
    prompt_config AWS_PROFILE "Enter default AWS profile (leave blank for none)"
    prompt_config BROWSER "Enter browser command (leave blank for system default)"
fi

# Create directories
run_with_sudo_if_needed mkdir -p "$INSTALL_DIR"
mkdir -p "$CONFIG_DIR"
mkdir -p "$SCRIPTS_DIR"

# Copy main script
run_with_sudo_if_needed cp bin/menu-script "$INSTALL_DIR/"
run_with_sudo_if_needed chmod +x "$INSTALL_DIR/menu-script"

# Copy scripts
cp scripts/* "$SCRIPTS_DIR/"
chmod +x "$SCRIPTS_DIR/"*

# Create user configuration file
cat > "$CONFIG_DIR/user_config.sh" << EOL
# User configuration for menu-script

INSTALL_DIR="$INSTALL_DIR"
SCRIPTS_DIR="$SCRIPTS_DIR"
CONFIG_DIR="$CONFIG_DIR"
AWS_PROFILE="$AWS_PROFILE"
BROWSER="$BROWSER"
EOL

echo "Installation completed. You can now run 'menu-script' from anywhere."
echo "Your scripts are installed in $SCRIPTS_DIR"
echo "Configuration is stored in $CONFIG_DIR/user_config.sh"
echo "You can edit this file directly to change settings in the future."
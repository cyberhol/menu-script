# Default configuration for menu-script
# This file will be created during installation and can be edited by the user

# Installation directory for the main script
INSTALL_DIR="$HOME/.local/bin"

# Directory for user scripts
SCRIPTS_DIR="$HOME/aws/scripts"

# Directory for configuration files
if [[ "$OSTYPE" == "darwin"* ]]; then
    CONFIG_DIR="$HOME/Library/Application Support/menu-script"
else
    CONFIG_DIR="$HOME/.config/menu-script"
fi

# Default AWS profile (can be left empty)
AWS_PROFILE=""

# Browser command (leave empty to use system default)
BROWSER=""
# Menu Script

A powerful and customizable CLI menu for managing and executing various scripts and commands, with a focus on AWS operations but it can be anything really. Inspired by [@omacox](https://github.com/omacox)'s unique ideas at [omacox/Scripts-and-Stuff](https://github.com/omacox/Scripts-and-Stuff). Please note that this repository will not stay public as I'll start adding member-only functionality.

## File Structure

```
cyberhol/menu-script/
├── bin/
│   └── menu-script
├── scripts/
│   ├── aws-cost-report.sh
│   └── (other .sh scripts)
├── install.sh
├── uninstall.sh
├── default_config.sh
├── config.json
└── README.md
```

## Features and Improvements

- **Customizable Installation**: Users can customize installation directories during setup.
- **Configuration Management**: Uses a separate configuration file for easy management.
- **Cross-Platform Compatibility**: Works on Linux and it may also work macOS.
- **AWS Profile Support**: Allows setting and using different AWS profiles.
- **Browser Integration**: Opens URLs in the default or specified browser.
- **Script Management**: Easy addition and execution of custom scripts.
- **Non-Interactive Mode**: Supports command-line arguments for scripting and automation.
- **Permission Handling**: Automatically uses sudo when necessary for installation.

## Installation

1. Clone the repository:
   ```
   git git@github.com:cyberhol/menu-script.git
   cd menu-script
   ```

2. Run the install script:
   ```
   ./install.sh
   ```

3. Default configuration:
   ```
   Current configuration:
   INSTALL_DIR: /home/$USER/.local/bin
   SCRIPTS_DIR: /home/$USER/aws/scripts
   CONFIG_DIR: /home/$USER/.config/menu-script
   Do you want to customize these settings? (y/n)
   ```

   You can customize these settings during installation.

4. Ensure your PATH includes the installation directory:
   Check your `~/.profile` for:
   ```bash
   # set PATH so it includes user's private bin if it exists
   if [ -d "$HOME/.local/bin" ]; then
       PATH="$HOME/.local/bin:$PATH"
   fi
   ```

   If necessary, run `source ~/.profile` to update your current session.

## Usage

### Interactive Mode

Simply run:
```
menu-script
```

### Non-Interactive Mode

```
menu-script [-h|--help] [-i|--item ID] [-s|--script SCRIPT_NAME] [SCRIPT_ARGS...]
```

Options:
- `-h, --help`: Display help message
- `-i, --item ID`: Execute a specific menu item
- `-s, --script SCRIPT`: Execute a specific script from the scripts directory
- `SCRIPT_ARGS`: Arguments to pass to the specified script

Example:
```
menu-script -s aws-cost-report.sh --help
```

Output:
```
Usage: scripts/aws-cost-report.sh [options]
Options:
  -s, --start-date YYYY-MM-DD   Start date (default: 1 month ago)
  -e, --end-date YYYY-MM-DD     End date (default: today)
  -g, --granularity GRAN        Granularity: DAILY|MONTHLY (default: MONTHLY)
  -m, --metric METRIC           Metric to use (default: UsageQuantity)
  -b, --group-by KEY            Group by: SERVICE|USAGE_TYPE|etc. (default: SERVICE)
  -o, --output FORMAT           Output format: table|json|text (default: table)
  -h, --help                    Display this help message
```

## Uninstallation

To remove the Menu Script CLI:

```
./uninstall.sh
```

This will remove the main script and configuration files. Your custom scripts in the SCRIPTS_DIR will not be deleted.

## Adding Your Own Scripts

1. Place your bash scripts in the `SCRIPTS_DIR` (default: `/home/$USER/aws/scripts`).
2. Ensure your scripts have a `-h` or `--help` option for displaying usage information.
3. The scripts will automatically be available in the menu.

## Configuration

The configuration file is stored in `CONFIG_DIR` (default: `/home/$USER/.config/menu-script/user_config.sh`).

You can edit this file to change:
- Installation directory
- Scripts directory
- Configuration directory
- Default AWS profile
- Browser command

## TODO

- [ ] Add AWS CLI 2 support

## Contributing

Feel free to answer questions and improve the code by submitting a pull request. Your contributions are welcome!

---

## A Bunch of Scripts

[menu1.sh](https://github.com/omacox/Scripts-and-Stuff/blob/main/code/menu1.sh) by [@omacox](https://github.com/omacox)

### menu1.sh

- tested on Mac OS Sonoma 14.6.1

- Menu Script for Command Line items for AWS and URL in Google Chrome

- You have to have your keys from AWS saved in the .aws folder and Chrome Browser on your

- Also use chmod on the this menu file ot allow to run : chmod +x filename.sh

- Use Automator for desktop icon open, select run shell script and add the two lines below

```bash
open -a Terminal /Users/$USER/scripts/menu1.sh
exit
```

- Then save to the deskop
- You are good to go

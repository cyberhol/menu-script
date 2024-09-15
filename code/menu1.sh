#!/bin/bash
# User Name 2024.09.14#!/bin/bash
# User Name 2024.09.14
# Menu Script for Command Line items for AWS and URL in Google Chrome
# You have to have your keys from AWS saved in the .aws folder and Chrome Browser on your 
# Also use chmod on the this menu file ot allow to run : chmod +x filename.sh
# Automator for desktop icon open select run shell script and add the two lines below
# open -a Terminal /Users/omacox/scripts/menu.sh
# exit
# Then save to the deskop
# Define the menu items
ITEMS=$(cat << EOF
24|Company Name|Private|User Name|List Users Company Name|aws iam list-users --query 'Users[*].{UserName:UserName, UserId:UserId, Arn:Arn, CreateDate:CreateDate, PasswordLastUsed:PasswordLastUsed}' --output table
28|Company Name|Private|User Name|List S3 Bucket Company Name|aws s3 ls s3://Company Name
130|AO LLC|Anthropic|User Name|Anthropic Prompt Library|https://docs.anthropic.com/en/prompt-library/library
EOF
)

# Function to display the menu
function show_menu() {
    clear
    printf "%-5s %-10s %-12s %-10s %-40s\n" "ID" "Access" "Provider" "User" "Title"
    echo "--------------------------------------------------------------------------------------------------------"
    # Use file descriptor 3 for reading ITEMS
    while IFS='|' read -r id access provider user title command <&3; do
        printf "%-5s %-10s %-12s %-10s %-40s\n" "$id" "$access" "$provider" "$user" "$title"
    done 3<<< "$ITEMS"
    echo "--------------------------------------------------------------------------------------------------------"
    echo "Enter ID to select an item, C to clear and return, X to exit."
}

# Function to execute the selected choice
function execute_choice() {
    local choice="$1"
    if [[ "$choice" == "C" || "$choice" == "c" ]]; then
        read -p "Press Enter to return to the menu..." < /dev/tty
        return
    elif [[ "$choice" == "X" || "$choice" == "x" ]]; then
        echo "Exiting..."
        exit 0
    elif [[ "$choice" =~ ^[0-9]+$ ]]; then
        # Search for the item with the matching ID
        local found=0
        # Use file descriptor 3 for reading ITEMS
        while IFS='|' read -r id access provider user title command <&3; do
            if [[ "$id" == "$choice" ]]; then
                found=1
                echo "----------------------------------------"
                echo "ID: $id"
                echo "Access: $access"
                echo "Provider: $provider"
                echo "User: $user"
                echo "Title: $title"
                echo "Command: $command"
                echo "----------------------------------------"
                echo "Executing..."
                echo "----------------------------------------"
                if [[ "$command" =~ ^https?:// ]]; then
                    # Open URL in default browser
                    open -a "Google Chrome" "$command"
                    echo "Opened URL in Google Chrome: $command"
                else
                    # Execute command in the current terminal and display output
                    # Redirect stdin from /dev/null to prevent command from reading input
                    bash -c "$command" < /dev/null
                fi
                echo "----------------------------------------"
                read -p "Press Enter to continue..." < /dev/tty
                break
            fi
        done 3<<< "$ITEMS"
        if [[ "$found" -eq 0 ]]; then
            echo "Invalid ID."
            read -p "Press Enter to continue..." < /dev/tty
        fi
    else
        echo "Invalid input."
        read -p "Press Enter to continue..." < /dev/tty
    fi
}

# Main loop
while true; do
    show_menu
    read -p "Enter your choice: " choice < /dev/tty
    execute_choice "$choice"
done

# Menu Script for Command Line items for AWS and URL in Google Chrome
# You have to have your keys from AWS saved in the .aws folder and Chrome Browser on your 
# Also use chmod on the this menu file ot allow to run : chmod +x filename.sh
# Define the menu items
ITEMS=$(cat << EOF
24|Company Name|Private|User Name|List Users Company Name|aws iam list-users --query 'Users[*].{UserName:UserName, UserId:UserId, Arn:Arn, CreateDate:CreateDate, PasswordLastUsed:PasswordLastUsed}' --output table
28|Company Name|Private|User Name|List S3 Bucket Company Name|aws s3 ls s3://Company Name
130|AO LLC|Anthropic|User Name|Anthropic Prompt Library|https://docs.anthropic.com/en/prompt-library/library
EOF
)

# Function to display the menu
function show_menu() {
    clear
    printf "%-5s %-10s %-12s %-10s %-40s\n" "ID" "Access" "Provider" "User" "Title"
    echo "--------------------------------------------------------------------------------------------------------"
    # Use file descriptor 3 for reading ITEMS
    while IFS='|' read -r id access provider user title command <&3; do
        printf "%-5s %-10s %-12s %-10s %-40s\n" "$id" "$access" "$provider" "$user" "$title"
    done 3<<< "$ITEMS"
    echo "--------------------------------------------------------------------------------------------------------"
    echo "Enter ID to select an item, C to clear and return, X to exit."
}

# Function to execute the selected choice
function execute_choice() {
    local choice="$1"
    if [[ "$choice" == "C" || "$choice" == "c" ]]; then
        read -p "Press Enter to return to the menu..." < /dev/tty
        return
    elif [[ "$choice" == "X" || "$choice" == "x" ]]; then
        echo "Exiting..."
        exit 0
    elif [[ "$choice" =~ ^[0-9]+$ ]]; then
        # Search for the item with the matching ID
        local found=0
        # Use file descriptor 3 for reading ITEMS
        while IFS='|' read -r id access provider user title command <&3; do
            if [[ "$id" == "$choice" ]]; then
                found=1
                echo "----------------------------------------"
                echo "ID: $id"
                echo "Access: $access"
                echo "Provider: $provider"
                echo "User: $user"
                echo "Title: $title"
                echo "Command: $command"
                echo "----------------------------------------"
                echo "Executing..."
                echo "----------------------------------------"
                if [[ "$command" =~ ^https?:// ]]; then
                    # Open URL in default browser
                    open -a "Google Chrome" "$command"
                    echo "Opened URL in Google Chrome: $command"
                else
                    # Execute command in the current terminal and display output
                    # Redirect stdin from /dev/null to prevent command from reading input
                    bash -c "$command" < /dev/null
                fi
                echo "----------------------------------------"
                read -p "Press Enter to continue..." < /dev/tty
                break
            fi
        done 3<<< "$ITEMS"
        if [[ "$found" -eq 0 ]]; then
            echo "Invalid ID."
            read -p "Press Enter to continue..." < /dev/tty
        fi
    else
        echo "Invalid input."
        read -p "Press Enter to continue..." < /dev/tty
    fi
}

# Main loop
while true; do
    show_menu
    read -p "Enter your choice: " choice < /dev/tty
    execute_choice "$choice"
done

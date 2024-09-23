#!/bin/bash

# name: AWS IAM Policy Search
# description: Search AWS IAM policies for specific actions

# Default values
search_term=""
aws_profile="default"

# Function to display usage
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -s, --search TERM    Action to search for in policies (required)"
    echo "  -p, --profile PROFILE AWS profile to use (default: default)"
    echo "  -h, --help           Display this help message"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -s|--search)
            search_term="$2"
            shift 2
            ;;
        -p|--profile)
            aws_profile="$2"
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# Check if search term is provided
if [ -z "$search_term" ]; then
    echo "Error: Search term is required."
    usage
    exit 1
fi

# Function to search policies
search_policies() {
    for arn in $(aws iam list-policies --scope Local --query 'Policies[*].Arn' --output text --profile "$aws_profile"); do
        version=$(aws iam get-policy --policy-arn "$arn" --query 'Policy.DefaultVersionId' --output text --profile "$aws_profile")
        policy_name=$(aws iam get-policy --policy-arn "$arn" --query 'Policy.PolicyName' --output text --profile "$aws_profile")
        if aws iam get-policy-version --policy-arn "$arn" --version-id "$version" --query 'PolicyVersion.Document' --output json --profile "$aws_profile" | grep -q "$search_term"; then
            echo "Policy Name: $policy_name"
            echo "Policy ARN: $arn"
            echo "---"
        fi
    done
}

# Run the search
echo "Searching for policies containing action: $search_term"
echo "Using AWS profile: $aws_profile"
echo "---"
search_policies
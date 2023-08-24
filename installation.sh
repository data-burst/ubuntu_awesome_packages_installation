#!/bin/bash

# Variable to store the command-line flags
flag=""
remove_repo=false
set_dns=""

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --local|--remote)
            flag=$1
            shift
            ;;
        --remove-repo)
            remove_repo=true
            shift
            ;;
        --set-dns)
            set_dns=$2
            shift 2
            ;;
        *)
            shift
            ;;
    esac
done



# Check if Ansible is installed and install it if not
if ! command -v ansible &> /dev/null; then
    echo "Ansible is not installed. Installing Ansible..."
    sudo apt update
    sudo apt install ansible -y
fi

# Set the repository URL
repo_url="https://github.com/data-burst/ubuntu_awesome_packages_installation.git"

# Clone the Ansible repository from GitHub
repo_name=$(basename "$repo_url" .git)
clone_dir="/tmp/$repo_name"

# Check if the directory already exists and is not empty
if [ -d "$clone_dir" ] && [ "$(ls -A "$clone_dir")" ]; then
    echo "Directory '$clone_dir' already exists and is not empty. Skipping cloning step."
else
    git clone "$repo_url" "$clone_dir"
fi

# Set DNS if set_dns is provided
if [ -n "$set_dns" ]; then
    # Add DNS entry to resolv.conf.j2 if it doesn't exist
    resolv_file="$clone_dir/roles/prerequisites/templates/resolv.conf.j2"
    if ! grep -qF "nameserver $set_dns" "$resolv_file"; then
        echo "nameserver $set_dns" >> "$resolv_file"
        echo "Added DNS entry to $resolv_file"
    else
        echo "DNS entry already exists in $resolv_file. Skipping."
    fi

    # Add DNS include to main.yml if it doesn't exist
    main_file="$clone_dir/roles/prerequisites/tasks/main.yml"
    dns_include="include_tasks: set-dns.yml"
    if ! grep -qF "$dns_include" "$main_file"; then
        echo "- $dns_include" >> "$main_file"
        echo "Added DNS include to $main_file"
    else
        echo "DNS include already exists in $main_file. Skipping."
    fi

    # Add DNS entry to cleanup/resolv.conf.j2 if it doesn't exist
    cleanup_resolv_file="$clone_dir/roles/cleanup/templates/resolv.conf.j2"
    if ! grep -qF "nameserver $set_dns" "$cleanup_resolv_file"; then
        echo "nameserver $set_dns" >> "$cleanup_resolv_file"
    fi

    # Add DNS include to cleanup/main.yml if it doesn't exist
    cleanup_main_file="$clone_dir/roles/cleanup/tasks/main.yml"
    cleanup_dns_include="include_tasks: remove-dns.yml"
    if ! grep -qF "$cleanup_dns_include" "$cleanup_main_file"; then
        echo "- $cleanup_dns_include" >> "$cleanup_main_file"
    fi
fi

# Check if the inventory file exists in the cloned repository
inventory_file="$clone_dir/inventory.yaml"

# Run Ansible with the appropriate options
if [ "$flag" == "--local" ]; then
    ansible-playbook -i "$inventory_file" install.yaml --connection=local --ask-become-pass
elif [ "$flag" == "--remote" ]; then
    inventory_path="" # Variable to store the custom inventory path

    # Parse command-line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --inventory)
                inventory_path=$2
                shift 2
                ;;
            *)
                shift
                ;;
        esac
    done

    # Validate inventory path
    if [ -z "$inventory_path" ]; then
        echo "Custom inventory path not provided. Please use the --inventory flag to specify the path to the inventory file."
        exit 1
    fi

    # Execute Ansible with the specified options
    ansible-playbook -i "$inventory_path" install.yaml
else
    echo "Invalid option. Please use either --local or --remote flag."
    exit 1
fi

# Remove the cloned repository from the user's system if the flag is set to true
if [ "$remove_repo" = true ]; then
    rm -rf "$clone_dir"
    echo "Cloned repository '$clone_dir' has been removed."
fi
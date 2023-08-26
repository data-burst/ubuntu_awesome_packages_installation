#!/bin/bash

# Variable to store the command-line flags
flag=""
remove_repo=false
set_dns=""
show_repo_location=false
use_ssh_key=false
ssh_key=""
# Variable to store the repository location
repo_location=""

# Function to display script usage
display_usage() {
    echo "Usage: $0 <--local|--remote> [--remove-repo] [--set-dns <DNS_IP>] [--show-repo-location] [--inventory <INVENTORY_PATH>] [--ssh-key <SSH_KEY_FILE>]"
    echo "Options:"
    echo "  --local                : Run the playbook on the local machine"
    echo "  --remote               : Run the playbook on a remote machine"
    echo "  --remove-repo          : Remove the cloned repository after execution"
    echo "  --set-dns <IP>         : Set a custom DNS IP"
    echo "  --show-repo-location   : Display the location of the cloned repository and exit"
    echo "  --inventory <PATH>     : Specify the path to the inventory file (required for --remote)"
    echo "  --ssh-key <SSH_KEY_FILE> : Specify the path to the SSH key file (required for --remote)"
    echo "  --user <USER>   : Specify the user for running Ansible (required for --local)"
}

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
        --show-repo-location)
            show_repo_location=true
            shift
            ;;
        --inventory)
            inventory_path=$2
            shift 2
            ;;
        --ssh-key)
            use_ssh_key=true
            ssh_key=$2
            shift 2
            ;;
        --user)
            user=$2
            shift 2
            ;;
        --help)
            display_usage
            exit 0
            ;;
        *)
            display_usage
            exit 1
            ;;
    esac
done

# Function to get the location of the cloned repository
get_repo_location() {
    # Logic to determine the repository location
    # Replace this with the actual logic to fetch the repository location
    repo_location="/tmp"
}

# Check if the --show-repo-location option is specified
if [ "$show_repo_location" = true ]; then
    get_repo_location
    echo "Cloned repository location: $repo_location"
    exit 0
fi

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
install_file="$clone_dir/install.yaml"

# Run Ansible with the appropriate options
if [ "$flag" == "--local" ]; then
    if [ -z "$user" ]; then
        echo "ERROR: --user option is required when using --local flag."
        display_usage
        exit 1
    fi
    
    sed -i "s/ansible_user: .*/ansible_user: $user/g" "$clone_dir/inventory.yaml"
    ansible-playbook -i "$inventory_file" "$install_file" --connection=local --ask-become-pass --user "$user"

elif [ "$flag" == "--remote" ]; then
    # Check if the --remote flag is used and enforce --ssh-key option
    if [ "$use_ssh_key" = false ]; then
        echo "Error: When using --remote, the --ssh-key option is required."
        display_usage
        exit 1
    fi
    # Validate inventory path
    if [ -z "$inventory_path" ]; then
        echo "Custom inventory path not provided. Please use the --inventory flag to specify the path to the inventory file."
        exit 1
    fi

    # Execute Ansible with the specified options
    ansible-playbook -i "$inventory_path" "$install_file" --private-key="$ssh_key"
else
    echo "Invalid option. Please use either --local or --remote flag."
    exit 1
fi

# Remove the cloned repository from the user's system if the flag is set to true
if [ "$remove_repo" = true ]; then
    rm -rf "$clone_dir"
    echo "Cloned repository '$clone_dir' has been removed."
fi

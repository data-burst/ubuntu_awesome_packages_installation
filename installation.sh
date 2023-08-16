#!/bin/bash

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
git clone "$repo_url" "$clone_dir"

# Check if the inventory file exists in the cloned repository
inventory_file="$clone_dir/inventory.yaml"
if [ ! -f "$inventory_file" ]; then
    echo "Inventory file '$inventory_file' not found in the cloned repository. Please make sure the repository contains the inventory file and try again."
    exit 1
fi

# Prompt the user to provide their own inventory file
read -p "Enter the path to your inventory file: " user_inventory_file

# Check if the user inventory file exists
if [ ! -f "$user_inventory_file" ]; then
    echo "User inventory file '$user_inventory_file' not found. Please make sure to provide a valid inventory file and try again."
    exit 1
fi

# Update the inventory file in the cloned repository based on the user inventory file
cp "$user_inventory_file" "$inventory_file"

# Run the Ansible playbook using the inventory file from the cloned repository
ansible-playbook -i "$inventory_file" "$clone_dir/install.yaml"

# Delete the cloned repository from the user's system
rm -rf "$clone_dir"
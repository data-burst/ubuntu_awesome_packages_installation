
# Ubuntu Awesome Packages 🎉

![ubuntu-awesome](assets/ubuntu-awesome.PNG)

A bash script to automatically set up your Ubuntu system with essential tools using Ansible.

## Features 🌠

- 🕵️‍♂️ **Automated Ansible Detection**: No manual checks needed. We handle Ansible's installation if it's missing.
- 🛠 **All-In-One Installation**: From foundational packages to key utilities and top-tier applications, our playbook gets your system ready in no time.
- 📦 **Diverse Toolset**: Whether it's enhancing your terminal, setting up system tools like Docker, or just ensuring you can enjoy media with VLC, we've got it all covered.

## How to Use 🚀

To run the installation script, you can use the following command:
---
---
```bash
curl -sSL "https://raw.githubusercontent.com/data-burst/ubuntu_awesome_packages_installation/installation.sh" | bash -s -- --local --user <USER> [--set-dns <DNS_IP>]
```
---
Replace **<USER>** with the desired user for running Ansible, and **<DNS_IP>** with the desired custom DNS IP if needed.

This command will download the script from the specified URL and execute it with the --local flag, indicating that the playbook should run on the local machine. The --user flag allows you to specify the user under which Ansible should be executed. The optional --set-dns flag can be used to set a custom DNS IP.

### Flags 🎏
**The installation script supports the following flags:**

- --local: Run the playbook on the local machine. 
- --remote: Run the playbook on a remote machine.
- --remove-repo: Remove the cloned repository after execution.
- --set-dns <IP>: Set a custom DNS IP.
- --show-repo-location: Display the location of the cloned repository and exit.
- --inventory <PATH>: Specify the path to the inventory file (required for --remote).
- --ssh-key <SSH_KEY_FILE>: Specify the path to the SSH key file (required for --remote).
- --user <USER>: Specify the user for running Ansible (required for --local).

### Running in Local Mode with Custom DNS 📌
If you want to run the playbook in local mode and set a custom DNS, you can use the following command:

---
```bash
curl -sSL "https://raw.githubusercontent.com/data-burst/ubuntu_awesome_packages_installation/installation.sh" | bash -s -- --local --user <USER> --set-dns <DNS_IP>
```
---
Replace **<USER>** with the desired user for running Ansible, and **<DNS_IP>** with the desired custom DNS IP.

The script will execute the playbook on the local machine, running as the specified user, and set the specified custom DNS IP. After the execution is complete, the custom DNS configuration will be removed.

### Running on a Remote Machine with Custom DNS 📌
If you want to run the playbook on a remote machine and set a custom DNS, you can use the following command:

---
```bash
curl -sSL "https://raw.githubusercontent.com/data-burst/ubuntu_awesome_packages_installation/installation.sh" | bash -s -- --remote --inventory /path/to/inventory --ssh-key /path/to/ssh/key [--set-dns <DNS_IP>]
```
---
Replace **/path/to/inventory** with the actual path to your inventory file, **<SSH_KEY_FILE>** with the path to your SSH key file, and **<DNS_IP>** with the desired custom DNS IP if needed.

Before running the command, make sure you have an SSH key set up. If you don't have an SSH key, you can generate one using the following command:

---
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
---
Replace **"your_email@example.com"** with your email address. Press Enter when prompted to specify the file in which to save the key (accept the default location) and to set a passphrase (optional).

To set the SSH key on the remote machine, you can use the ssh-copy-id command. Here's an example:

---
```bash
ssh-copy-id -i <SSH_KEY_FILE> user@remote_host
```
---
Replace **<SSH_KEY_FILE>** with the path to your SSH public key file and user@remote_host with the username and hostname of the remote machine.

Once the SSH key is set on the remote machine, you can use the --remote flag along with the appropriate inventory file and SSH key file paths in the installation script command mentioned earlie

### Creating the Inventory File 📌
To create an inventory file for remote machine configurations, follow these steps:

1. Open a text editor and create a new file.

2. Copy the following content into the file:

---
```bash
---
all:
  hosts:
    virtualmachine01:
      ansible_host: 127.0.0.1
      ansible_user: root
      description: The first development machine
  children:
    dev_machines:
      hosts:
        virtualmachine01:

```
---
3. Save the file with a .yaml extension, for example, inventory.yaml.

4. Customize the inventory file by replacing the values (virtualmachine01, 127.0.0.1, root, and the description) with the appropriate values for your setup. You can add more hosts and groups as needed.


Now you can use the created inventory file by providing its path with the --inventory flag when running the script with the --remote flag.

Note: Ensure that you replace **/path/to/inventory** and **/path/to/ssh/key** in the examples with the actual paths to your inventory file and SSH key.

Feel free to customize the commands and instructions according to your specific requirements and configurations.

## Tools Installed 🧰

Here are some of the tools our Ansible playbook will install:

- Prerequisites: `python3`, `python3-pip`, `python3-setuptools`, `virtualenv`, `make`, `build-essential`, `wget`, `curl`, `apt-transport-https`, `ca-certificates`, `gnupg`, `tree`, `git`, `xz-utils`, `tk-dev`, `libffi-dev`, `liblzma-dev`, `libssl-dev`, `zlib1g-dev`, `libbz2-dev`, `libreadline-dev`, `libsqlite3-dev`, `libncurses5-dev`, `libncursesw5-dev`
- Shell Utilities: `zsh`, `oh-my-zsh`, `zsh-autosuggestion`, `vim`, `nvim`, `alacritty`, `terminator`, `byobu`, `fd-find`, `fuzzy-finder`, `xclip`, `autojump`, `fuck`
- Tools:  `open-ssh`, `snap-package-manager`, `docker`, `kubectl`, `htop`, `iftop`, `iostat`, `iotop`, `tweak`, `shadowsocks`, `v2ray-plugin`, `gnome-extension`, `telegram`, `vlc`

## Contributions 🤝

Open to suggestions and improvements! If there's a tool or utility you'd like to see added, or any other enhancements, feel free to contribute.

## License

Licensed under the MIT License. Check [LICENSE.md](LICENSE.md) for more details.


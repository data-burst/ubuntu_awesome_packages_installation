# Pre-requisites

- [X] python, pip, and virtualenv
    ```bash
    sudo apt install -y python3 python3-pip virtualenv
    ```
# Shell
- [X] ZSH and Oh-my-zsh
    ```bash
    sudo apt install -y zsh
    chsh -s $(which zsh)
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ```
- [ ] p10k
    ```bash
    # source: https://github.com/romkatv/powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    # Set ZSH_THEME="powerlevel10k/powerlevel10k" in ~/.zshrc
    ```
- [X] auto-complete
    ```
    # source: https://github.com/zsh-users/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    ```
- [X] fuzzy search finder
    ```bash
    sudo apt-get install fzf
    echo "source /usr/share/doc/fzf/examples/key-bindings.zsh" >> ~/.zshrc
    echo "source /usr/share/doc/fzf/examples/completion.zsh" >> ~/.zshrc
    ```

- [X] xclip
    ```bash
    sudo apt install -y xclip
    echo "alias clipboard='xclip -sel clip'" >> ~/.zshrc
    ```

- [X] fuck

- [X] Docker
- [X] Kubectl
- [X] Shadowsocks
    ```bash
    sudo apt install shadowsocks-libev
    ```
- [X] v2ray
    ```
    wget https://github.com/shadowsocks/v2ray-plugin/releases/download/v1.3.2/v2ray-plugin-linux-amd64-v1.3.2.tar.gz
    tar -xvzf v2ray-plugin-linux-amd64-v1.3.2.tar.gz 
    sudo mv v2ray-plugin_linux_amd64 /etc/shadowsocks-libev
    ```

- [X] byobu
    ```
    sudo apt install byobu
    ```
- [X] Gnome extensions
    ```bash
    sudo apt install -y gnome-shell-extensions
    sudo apt install -y chrome-gnome-shell
    ```

- [X] vim 
    ```bash
    sudo apt install -y vim
    ```
- [X] nvim
- [X] autojump
    ```bash
    sudo apt install -y autojump
    # add autojump to plugins of ~/.zshrc
    ```

- [ ] .ssh files
- [X] telegram
- [X] tweak
    ```bash
    sudo add-apt-repository universe
    sudo apt install -y gnome-tweaks gnome-shell-extension-manager
    # gnome-tweaks
    ```

- [X] alacritty
    ```bash
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
    sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

    ```
# Utilities

## Find
- https://github.com/sharkdp/fd


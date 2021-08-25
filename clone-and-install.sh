#!/usr/bin/env bash
# Check for git existence
if ! command -v git &> /dev/null; then
    echo "git required! Exiting..."
    exit
fi

# Clone repo, cd, run install
cd ~
git clone https://github.com/Raymo111/dotfiles.git
cd dotfiles
. ~/dotfiles/.bash_functions
confirm "Install dotfiles? [y/N]" && ./install.sh || echo "Exiting..."
cd ..

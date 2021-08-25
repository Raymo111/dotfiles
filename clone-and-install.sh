#!/usr/bin/env bash
# Check for git existence
if ! command -v git &> /dev/null; then
    echo "git required! Exiting..."
    exit
fi

# Clone repo, cd, run install
cd ~
git clone https://github.com/Raymo111/dotfiles.git
echo "Repo cloned!"
cd dotfiles
. ~/dotfiles/.bash_functions
confirm "Install dotfiles? [y/N]" || echo "Exiting..." && exit
./install.sh
cd ..

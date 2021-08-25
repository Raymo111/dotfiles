#!/usr/bin/env bash
# Check for git existence
if ! command -v git &> /dev/null; then
    echo "git required! Exiting..."
    exit
fi

# Clone repo, cd, run install
cd ~
git clone https://github.com/Raymo111/dotfiles.git ~/dotfiles
cd dotfiles
./install.sh
cd ..

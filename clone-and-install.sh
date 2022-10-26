#!/usr/bin/env bash

# Usage: curl -sSL raymo.ml | bash

# Check for git existence
if ! command -v git &> /dev/null; then
    echo "git required! Exiting..."
    exit
fi

# Clone repo, cd, run install
cd ~ || exit
git clone https://github.com/Raymo111/dotfiles.git ~/dotfiles
cd dotfiles || exit
./install.sh
cd ..

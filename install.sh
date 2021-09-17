#!/usr/bin/env bash
# Select backup directory
BACKUPDIR=~/.dotfiles_backup
if [ -e $BACKUPDIR ]; then
    BACKUPDIR=~/.dotfiles_backup1
    if [ -e $BACKUPDIR ]; then
        BACKUPDIR=~/.dotfiles_backup2
        if [ -e $BACKUPDIR ]; then
            BACKUPDIR=~/.dotfiles_backup3
            if [ -e $BACKUPDIR ]; then
                BACKUPDIR=~/.dotfiles_backup4
            fi
        fi
    fi
fi

# Backup
if [ -e ~/.bash_functions ] || [ -e ~/.bashrc ] || \
    [ -e ~/.selected_editor ] || [ -e ~/.bash_aliases ] || [ -e ~/scripts ] || \
    [ -e ~/.aliases ] || [ -e ~/.vimrc ]; then
    echo "Existing dotfiles found, backing up..."
    if [ -e $BACKUPDIR ]; then
        echo "BACKUPDIR exists, exiting..."
        exit
    fi
    mkdir $BACKUPDIR
    mv ~/.bash_functions ~/.bashrc ~/.selected_editor ~/.bash_aliases \
        ~/scripts ~/.aliases ~/.vimrc $BACKUPDIR 2>/dev/null || true
fi

# Copy files
cp -al .bash_functions .bashrc .selected_editor .vimrc scripts ~
mkdir ~/.aliases/
cp -al .aliases/bash ~/.aliases/

# Arch
if [ -f "/etc/arch-release" ]; then
    echo "Arch Linux detected (yay!) (btwiusearch), copying Arch-specific aliases"
    cp -al .aliases/arch ~/.aliases/distro
fi

# Android
if command -v termux-setup-storage; then
    echo "Termux detected, copying Termux-specific aliases"
    cp -al .aliases/termux ~/.aliases/distro
fi

# MacOS
if [[ $OSTYPE == 'darwin'* ]]; then
    echo "MacOS detected, copying MacOS-specific aliases"
    cp -al .aliases/mac ~/.aliases/distro
fi

if [[ $XDG_SESSION_TYPE == "x11" ]]; then
    echo "$XDG_SESSION_TYPE detected, copying graphical aliases"
    cp -al .aliases/graphical ~/.aliases/graphical
fi

echo "Installation done!"

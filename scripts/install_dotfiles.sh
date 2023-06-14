#!/usr/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
DOTFILES_DIR="$(dirname -- "$SCRIPT_DIR")/dotfiles"

BACKUP=~/.dotfiles_backup

BASH_PROFILE=bash_profile
BASHRC=bashrc
TMUX_CONF=tmux.conf
XINITRC=xinitrc
I3=i3
NVIM=nvim

mkdir -p "$BACKUP"
mv ~/.$BASH_PROFILE $BACKUP &>/dev/null
mv ~/.$BASHRC $BACKUP &>/dev/null
mv ~/.$TMUX_CONF $BACKUP &>/dev/null
mv ~/.$XINITRC $BACKUP &>/dev/null
mv ~/.config/$I3 $BACKUP &>/dev/null
mv ~/.config/$NVIM $BACKUP &>/dev/null

ln -s $DOTFILES_DIR/$BASH_PROFILE ~/.$BASH_PROFILE
ln -s $DOTFILES_DIR/$BASHRC ~/.$BASHRC
ln -s $DOTFILES_DIR/$TMUX_CONF ~/.$TMUX_CONF
ln -s $DOTFILES_DIR/$XINITRC ~/.$XINITRC
ln -s $DOTFILES_DIR/$I3 ~/.config/$I3
ln -s $DOTFILES_DIR/$NVIM ~/.config/$NVIM

if [[ -z "$(ls -A $BACKUP)" ]]; then
    rmdir $BACKUP
else
    echo "Backup files copied to $BACKUP"
fi

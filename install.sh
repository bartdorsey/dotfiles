#!/bin/sh
# ZSH
ln -sfv "$(pwd)/.zshenv" "$HOME/.zshenv"
# .config folder
ln -sfv "$(pwd)/.config/*" "$HOME/.config/"
# tmux
ln -sfv "$(pwd)/.tmux.conf" "$HOME/.tmux.conf"
ln -sfv "$(pwd)/.tmux/*" "$HOME/.tmux/"
# SSH Setup
if [ ! -d "$HOME/.ssh" ]; then
    mkdir "$HOME/.ssh"
fi
ln -sfv "$(pwd)/.ssh/config" "$HOME/.ssh/config"


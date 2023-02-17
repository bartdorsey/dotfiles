#!/bin/zsh
#
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

PLUGIN_DIR=${0:h}

# ZSH
ln -sfv "${PLUGIN_DIR}/.zshenv" "$HOME/.zshenv"
# .config folder
ln -sfv "${PLUGIN_DIR}/.config/"* "$HOME/.config/"
# tmux
ln -sfv "${PLUGIN_DIR}/.tmux.conf" "$HOME/.tmux.conf"
ln -sfv "${PLUGIN_DIR}/.tmux/"* "$HOME/.tmux/"
# SSH Setup
if [ ! -d "$HOME/.ssh" ]; then
    mkdir "$HOME/.ssh"
fi
ln -sfv "${PLUGIN_DIR}/.ssh/config" "$HOME/.ssh/config"


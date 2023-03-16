#!/bin/zsh
#
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

PLUGIN_DIR=${0:h}

# ZSH
ln -sf "${PLUGIN_DIR}/.zshenv" "$HOME/.zshenv"
# .config folder
ln -sf "${PLUGIN_DIR}/.config/"* "$HOME/.config/"
# tmux
ln -sf "${PLUGIN_DIR}/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "${PLUGIN_DIR}/.tmux/"* "$HOME/.tmux/"
# SSH Setup
if [ ! -d "$HOME/.ssh" ]; then
    mkdir "$HOME/.ssh"
fi
ln -sf "${PLUGIN_DIR}/.ssh/config" "$HOME/.ssh/config"

if [ ! -d "$HOME/.local/bin" ];then
    mkdir -p "$HOME/.local/bin"
fi

ln -sf "${PLUGIN_DIR}/bin/"* "$HOME/.local/bin/"

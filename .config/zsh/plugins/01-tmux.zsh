if [[ $(uname -s) == "Darwin" ]]; then
   /usr/bin/tic -x -o $HOME/.local/share/terminfo $HOME/.dotfiles/terminfo/tmux-256color.info 
   export TERMINFO_DIRS=$TERMINFO_DIRS:$HOME/.local/share/terminfo
fi

if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
   git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi


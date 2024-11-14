# History
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_find_no_dups

# Hack to make colors work again in new groff
export GROFF_NO_SGR=1

# Making the zsh directory if it doesn't exist already
if [ ! -d $XDG_STATE_HOME/zsh ];then
    mkdir -p $XDG_STATE_HOME/zsh
fi

# Set zsh's history file
HISTFILE=$XDG_STATE_HOME/zsh/history

# Run common env.sh
source $HOME/.config/common/env.sh


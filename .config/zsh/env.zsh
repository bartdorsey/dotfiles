# History
HISTSIZE=10000
SAVEHIST=10000

if [ ! -d $HOME/.cache/zsh ];then
    mkdir -p $HOME/.cache/zsh
fi

HISTFILE=$HOME/.cache/zsh/history

# Local bin
if [ -d "$HOME/.local/bin" ];then
    export PATH=$HOME/.local/bin:$PATH:
fi

# Rust
if [ -d "$HOME/.cargo/bin" ];then
    export PATH=$HOME/.cargo/bin:$PATH:
fi

# Nix PATH
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then 
    . $HOME/.nix-profile/etc/profile.d/nix.sh;
fi

# t script
if [ -d $HOME/.tmux/plugins/t-smart-tmux-session-manager ];then
    export PATH=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
fi

# FZF Config
if type fzf > /dev/null; then
    export FZF_DEFAULT_COMMAND='fdfind -type f --color=never --hidden'
    export FZF_DEFAULT_OPTS='--no-height'
fi

# Prompt Title
if type lsb_release > /dev/null;then
    if [[ $OSTYPE == "linux-gnu" ]]; then
        export PROMPT_TITLE=$(lsb_release -d | awk '{print $2 " " $3 " " $4}')
    fi
fi

# Default editor
export EDITOR="vim"

# Postgres
export PGHOST=localhost

# Python
if type python3 > /dev/null;then
    export SETUPTOOLS_USE_DISTUTILS=stdlib
    export PIPENV_VENV_IN_PROJECT=1
fi

# Go
if [ -d "$HOME/go" ];then
    export PATH=$PATH:~/go/bin
fi

# Man pages in bat
if type bat > /dev/null; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    fpath=($HOME/.config/zsh/functions $fpath)
fi

# GIT
export GIT_CONFIG_GLOBAL=$HOME/.config/git/config

# BUN
if [ -d "$HOME/.bun" ]; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
fi

# Homebrew
if [ -d "/opt/homebrew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi


# TERMINFO for tmux when it's not installed by default
if [[ $(toe -a | grep -c tmux-256color) != "0" ]]; then
   /usr/bin/tic -x -o $HOME/.local/share/terminfo $HOME/.dotfiles/terminfo/tmux-256color.info 
   export TERMINFO_DIRS=$TERMINFO_DIRS:$HOME/.local/share/terminfo
fi

# Bob
if [ -d "$HOME/.local/share/bob/nvim-bin" ];then
    export PATH=$HOME/.local/share/bob/nvim-bin:$PATH
fi

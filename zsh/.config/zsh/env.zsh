# History
HISTSIZE=10000
SAVEHIST=10000

if [ ! -d $HOME/.cache/zsh ];then
    mkdir -p $HOME/.cache/zsh
fi

HISTFILE=$HOME/.cache/zsh/history

#Nix setup
if [ ! -e /nix ]; then
    sh <(curl -L https://nixos.org/nix/install) --daemon
fi

if type grc > /dev/null;then
    export GRC_ALIASES=true
fi

if [ -d $HOME/.nix-profile/etc/profile.d ] ; then
    for i in $HOME/.nix-profile/etc/profile.d/*.sh; do
        if [ -r $i ]; then
            . $i
        fi
    done
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

# Man pages in bat
if type bat > /dev/null; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    fpath=($HOME/.config/zsh/functions $fpath)
fi

# GIT
export GIT_CONFIG_GLOBAL=$HOME/.config/git/config

# TERMINFO for tmux when it's not installed by default
if [[ $(toe -a | grep -c tmux-256color) == "0" ]]; then
    sudo /usr/bin/tic -xe tmux-256color $HOME/.dotfiles/terminfo/terminfo.src
fi

# SECRETS
if type pass > /dev/null; then
    export OPENAI_API_KEY=$(pass openai)
fi

# Bob
if type bob > /dev/null; then
    export PATH=$HOME/.local/share/bob/nvim-bin:$PATH
fi

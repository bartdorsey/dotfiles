# History
HISTSIZE=10000
SAVEHIST=10000

# Hack to make colors work again in new groff
export GROFF_NO_SGR=1

if [ ! -d $HOME/.cache/zsh ];then
    mkdir -p $HOME/.cache/zsh
fi

export BROWSER="xdg-open"

HISTFILE=$HOME/.cache/zsh/history

# MacPorts
if [ -x /opt/local/bin/port ];then
    export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
    export MANPATH="/opt/local/share/man:$PATH"
fi

# X11
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc

# KDE
export KDEHOME="$XDG_CONFIG_HOME"/kde

# Rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

# GPG
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# GTK
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"

# Java
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java"

# Node
export NODE_REPL_HISTORY="${XDG_CACHE_HOME}/node_repl_history"
export npm_config_cache="${XDG_CACHE_HOME}/npm"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"

# Nvidia CUDA
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}/nv"
export __GL_SHADER_DISK_CACHE_PATH="${XDG_CACHE_HOME}/nv"

# OCaml
export OPAMROOT="${XDG_DATA_HOME}/opam"

# Pass
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/pass"

# wget
alias wget="wget --hsts-file="${XDG_CACHE_HOME}/wget-hsts""

# GRC
if type grc > /dev/null; then
    if [ -e /etc/grc.zsh ]; then
        source /etc/grc.zsh
    fi
fi

# FZF Config
if type fzf > /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
    export FZF_DEFAULT_OPTS='--no-height'
fi

# Prompt Title
if type lsb_release > /dev/null;then
    if [[ $OSTYPE == "linux-gnu" ]]; then
        export PROMPT_TITLE=$(lsb_release -d | awk '{print $2 " " $3 " " $4}')
    fi
fi

# Default editor
export EDITOR="nvim"

# vimrc location
export VIMINIT="source $XDG_CONFIG_HOME/vim/vimrc"

# Postgres
export PGHOST=postgres.home
export PGUSER=postgres

# Python
if type python3 > /dev/null;then
    export SETUPTOOLS_USE_DISTUTILS=stdlib
    export PIPENV_VENV_IN_PROJECT=1
fi

# Man pages in bat
if type nvim > /dev/null; then
    export MANPAGER="nvim +Man!"
fi

# Git pager
if type nvimpager > /dev/null; then
    export PAGER=nvimpager
fi

# GIT
export GIT_CONFIG_GLOBAL=$HOME/.config/git/config

# TERMINFO for tmux when it's not installed by default
if type toe > /dev/null; then
    if [[ $(toe -a | grep -c tmux-256color) == "0" ]]; then
        sudo /usr/bin/tic -xe tmux-256color $HOME/.config/terminfo/terminfo.src
    fi
fi

# SECRETS
if type pass > /dev/null; then
    export OPENAI_API_KEY=$(pass openai)
fi

# Bob
if type bob > /dev/null; then
    export PATH=$HOME/.local/share/bob/nvim-bin:$PATH
fi

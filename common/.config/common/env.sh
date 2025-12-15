# MacPorts
if [ -x /opt/local/bin/port ];then
    export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
    export MANPATH="/opt/local/share/man:$PATH"
fi

# Ansible
export ANSIBLE_HOME="$XDG_DATA_HOME"/ansible

# Cabal Haskell
export CABAL_CONFIG="$XDG_CONFIG_HOME"/cabal/config
export CABAL_DIR="$XDG_DATA_HOME"/cabal

# Perl
export PERL_CPANM_HOME="$XDG_CACHE_HOME"/cpanm

# Cuda
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv

# Docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

# DotNet
export DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet

# X11
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc

# KDE
export KDEHOME="$XDG_CONFIG_HOME"/kde

# Rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

# GPG
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# Go
export GOPATH="$XDG_DATA_HOME"/go

# GTK
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"

# Java
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java"

# Node
export NODE_REPL_HISTORY="${XDG_CACHE_HOME}/node_repl_history"
export npm_config_cache="${XDG_CACHE_HOME}/npm"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export PATH="${XDG_DATA_HOME}/npm/bin:${PATH}"

# Nvidia CUDA
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}/nv"
export __GL_SHADER_DISK_CACHE_PATH="${XDG_CACHE_HOME}/nv"

# OCaml
export OPAMROOT="${XDG_DATA_HOME}/opam"

# Pass
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/pass"


# Default editor
export EDITOR="nvim"

# Default Terminal
export TERMINAL="wezterm start"

# vimrc location
export VIMINIT="source $XDG_CONFIG_HOME/vim/vimrc"

# Postgres
export PGHOST=postgres.home
export PGUSER=postgres

# Pyenv
if type pyenv > /dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# iPython
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"

# Python
export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"

# Jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter

# ICEAuthority
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority

# libx11
export XCOMPOSECACHE="$XDG_CACHE_HOME"/X11/xcompose

# mplayer
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer

# nb
export NB_DIR="$XDG_DATA_HOME/nb"

# Python
if type python3 > /dev/null 2>&1; then
    # export SETUPTOOLS_USE_DISTUTILS=stdlib
    export PIPENV_VENV_IN_PROJECT=1
fi

# PGPass
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"

# PostgreSQL
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"

# RBENV
export RBENV_ROOT="$XDG_DATA_HOME"/rbenv

# Sqlite
export SQLITE_HISTORY="$XDG_CACHE_HOME"/sqlite_history

# w3m
export W3M_DIR="$XDG_DATA_HOME"/w3m

# wine
export WINEPREFIX="$XDG_DATA_HOME"/wine

# Man pages in bat
if type nvim > /dev/null 2>&1; then
    export MANPAGER="nvim +Man!"
fi

# Git pager
if type nvimpager > /dev/null 2>&1; then
    export PAGER=nvimpager
fi

# GIT
export GIT_CONFIG_GLOBAL=$HOME/.config/git/config

# TERMINFO for tmux when it's not installed by default
if type toe > /dev/null 2>&1; then
    if [[ $(toe -a | grep -c tmux-256color) == "0" ]]; then
        sudo /usr/bin/tic -xe tmux-256color $HOME/.config/terminfo/terminfo.src
    fi
fi

# SECRETS
#if type pass > /dev/null; then
#    export OPENAI_API_KEY=$(pass openai)
#fi

# Bob
if type bob > /dev/null 2>&1; then
    export PATH=$HOME/.local/share/bob/nvim-bin:$PATH
fi

# Prettierd
if type prettierd > /dev/null 2>&1; then
    export PRETTIERD_DEFAULT_CONFIG="$HOME/.config/prettierrc.json"
fi

# Make
if [ -f /proc/cpuinfo ]; then
    export MAKEFLAGS="-j $(grep -c ^processor /proc/cpuinfo)"
fi

# Dev mode
# This sets up an environment variable called DEVMODE
# My nvim config pays attention to this to decide what plugins to load
# touch ~/.config/devmode to enable on a box
if [ -f ~/.config/devmode ]; then
    export DEVMODE=1
fi

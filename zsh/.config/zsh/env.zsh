# History
HISTSIZE=10000
SAVEHIST=10000

if [ ! -d $HOME/.cache/zsh ];then
    mkdir -p $HOME/.cache/zsh
fi

export BROWSER="xdg-open"

HISTFILE=$HOME/.cache/zsh/history

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

# Go
export GOPATH="${XDG_DATA_HOME}/go"
export PATH=$PATH:$GOPATH/bin

# wget
alias wget="wget --hsts-file="${XDG_CACHE_HOME}/wget-hsts""

#Nix setup
# if [ ! -e /nix ]; then
#     sh <(curl -L https://nixos.org/nix/install) --daemon
# fi
#
# if type grc > /dev/null;then
#     export GRC_ALIASES=true
# fi
#
# if [ -d $HOME/.nix-profile/etc/profile.d ] ; then
#     for i in $HOME/.nix-profile/etc/profile.d/*.sh; do
#         if [ -r $i ]; then
#             . $i
#         fi
#     done
# fi

# GRC
if type grc > /dev/null; then
    if [ -e /etc/grc.zsh ]; then
        source /etc/grc.zsh
    fi
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
export EDITOR="nvim"

# vimrc location
export VIMINIT="source $XDG_CONFIG_HOME/vim/vimrc"

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
    sudo /usr/bin/tic -xe tmux-256color $HOME/.config/terminfo/terminfo.src
fi

# SECRETS
if type pass > /dev/null; then
    export OPENAI_API_KEY=$(pass openai)
fi

# Bob
if type bob > /dev/null; then
    export PATH=$HOME/.local/share/bob/nvim-bin:$PATH
fi

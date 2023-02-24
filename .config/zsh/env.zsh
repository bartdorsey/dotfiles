# PATH
export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH:
# t script
export PATH=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
# FZF Config
FZF_DEFAULT_COMMAND='fdfind -type f --color=never --hidden'
FZF_DEFAULT_OPTS='--no-height'
# Prompt Title
if [[ $OSTYPE == "linux-gnu" ]]; then
    PROMPT_TITLE=$(lsb_release -d | awk '{print $2 " " $3 " " $4}')
fi
# Default editor
export EDITOR="vim"
# Postgres
export PGHOST=localhost
# Python
export SETUPTOOLS_USE_DISTUTILS=stdlib
export PIPENV_VENV_IN_PROJECT=1
# Go
export PATH=$PATH:~/go/bin
# Man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fpath=($HOME/.config/zsh/functions $fpath)
# GIT
GIT_CONFIG_GLOBAL=$HOME/.config/git/config
# BUN
export BUN_INSTALL="/home/echo/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

if [ -d "/opt/homebrew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Bob
if [ -d "$HOME/.local/share/bob/nvim-bin" ];then
    export PATH=$HOME/.local/share/bob/nvim-bin:$PATH
fi

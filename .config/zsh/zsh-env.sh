# PATH
export PATH=$HOME/.local/bin:$PATH
# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
# FZF Config
FZF_DEFAULT_COMMAND='fdfind -type f --color=never --hidden'
FZF_DEFAULT_OPTS='--no-height'
# Prompt Title
# PROMPT_TITLE=$(lsb_release -d | awk '{print $2 " " $3 " " $4}')
DISABLE_AUTO_TITLE="false"
# Default editor
export EDITOR="code -w"
# Postgres
export PGHOST=localhost
# Python
export SETUPTOOLS_USE_DISTUTILS=stdlib
export PIPENV_VENV_IN_PROJECT=1
# Rust
export PATH=$PATH:~/.cargo/bin
# Man pages
export MANPAGER='nvim +Man!'
fpath=($HOME/.config/zsh/functions $fpath)
# GIT
GIT_CONFIG_GLOBAL=$HOME/.config/git/config


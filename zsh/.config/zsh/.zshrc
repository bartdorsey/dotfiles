zmodload zsh/zprof

# Add zsh-completions to fpath
# On NixOS/home-manager: completions are directly in the plugin directory
# On manual clone: completions are in the src/ subdirectory
if [[ -d "$HOME/.local/share/zsh/plugins/zsh-completions/src" ]]; then
  fpath=($HOME/.config/zsh/completions $HOME/.local/share/zsh/plugins/zsh-completions/src $fpath)
else
  fpath=($HOME/.config/zsh/completions $HOME/.local/share/zsh/plugins/zsh-completions $fpath)
fi

# --- Setup a sane default prompt ---

# Load vcs_info
autoload -Uz vcs_info

# Tetris, because why not
autoload -Uz tetriscurses
alias tetris=tetriscurses

# Hook vcs_info into the precmd (executed before every prompt)
precmd() { vcs_info }

# Enable vcs_info for git
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats "%F{cyan}(%s) %b%f %u %c "
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}(staged)%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}(modified)%f'

# Customize the format for git info

# Ensure the prompt is re-evaluated
setopt prompt_subst

# Update your prompt to include the vcs_info message
PS1='${vcs_info_msg_0_}
%F{green}%/%f
%F{yellow}%#%f '

# --- End prompt setup ---

# Run .profile if it exists
if [ -e "$HOME/.profile" ]; then
    source "$HOME/.profile"
fi

# Vi mode
bindkey -v

# Set up run-help and alias to help
autoload -Uz run-help run-help-git run-help-ip run-help-openssl run-help-p4 run-help-sudo run-help-svk run-help-svn
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help

# Skip global compinit initialization in Ubuntu
skip_global_compinit=1

# Load utils
source $HOME/.config/common/utils.sh

# Load zsh functions
source $ZDOTDIR/zsh-functions.zsh

# Configure colors for zsh
autoload -U colors && colors

# Configure LS_COLORS
if type dircolors > /dev/null; then
    eval $(dircolors)
fi

# Configure zmv
autoload zmv

# Setting zsh's cache
if [[ ! -d "$XDG_CACHE_HOME"/zsh ]]; then
    mkdir "$XDG_CACHE_HOME/zsh"
fi

# Configure completion for zsh
autoload -U compinit
zstyle ':completion:*' menu no
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-dirs-first
zstyle ':completion:*' list-grouped
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --icon always $realpath'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' complete-options true
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix sufix
zmodload zsh/complist
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
_comp_options+=(globdots)
unsetopt listambiguous
setopt AUTO_LIST
LISTMAX=-1

# Home assistant completions
if type ha > /dev/null; then
    source <(ha completion zsh) && compdef _ha ha
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Stop Ctrl-S freezing the terminal
stty stop undef

# Path
source $ZDOTDIR/path.zsh

# Devtools
if [[ $DEVMODE ]]; then
    source $ZDOTDIR/devtools.zsh
fi

# WSL
source $ZDOTDIR/wsl.zsh

# FZF
source $HOME/.config/common/fzf.sh

# Plugins
source $ZDOTDIR/zsh-plugins.zsh

# Aliases
source $HOME/.config/common/aliases.sh

# Prompt
source $ZDOTDIR/prompt.zsh

# Title
source $ZDOTDIR/title.zsh

# Keybinds for OSes like Arch
source $ZDOTDIR/keybinds.zsh

# SSH Agent
source $ZDOTDIR/ssh-agent.zsh

# VSCode Integration
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

autoload -Uz add-zsh-hook

function reset_broken_terminal () {
	printf '%b' '\e[0m\e(B\e)0\017\e[?5l\e7\e[0;0r\e8'
}

add-zsh-hook -Uz precmd reset_broken_terminal

# Tinty setup
if type tinty > /dev/null; then
    tinty init
fi

# Setup pkgfile's command not found
if [ -f /usr/share/doc/pkgfile/command-not-found.zsh ]; then
    source /usr/share/doc/pkgfile/command-not-found.zsh
fi

# Allow root apps to display
if [ -n "$DISPLAY" ]; then
    xhost +local:root >/dev/null 2>&1
fi

# MOTD
source $HOME/.config/common/fetch.sh

# Wezterm
source $HOME/.config/common/wezterm.sh

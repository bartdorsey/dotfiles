# Profiler
zmodload zsh/zprof

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

# Base 16
# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
    source "$BASE16_SHELL/profile_helper.sh"

base16_rose-pine

# Skip global compinit initialization in Ubuntu
skip_global_compinit=1
# Load zsh functions
source $ZDOTDIR/zsh-functions.sh

# Configure colors for zsh
autoload -U colors && colors

# Configure LS_COLORS
if type dircolors > /dev/null; then
    eval $(dircolors)
fi

# Configure zmv
autoload zmv

# Configure completion for zsh
zsh_configure_completion

# Run compinit
if [[ ! -d "$XDG_CACHE_HOME"/zsh ]]; then
    mkdir "$XDG_CACHE_HOME/zsh"
fi
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

# Stop Ctrl-S freezing the terminal
stty stop undef

# Path
zsh_config_run path.zsh

# find the command on arch
if [ -e /usr/share/doc/find-the-command/ftc.zsh ]; then
    source /usr/share/doc/find-the-command/ftc.zsh
fi

# Plugins
zsh_config_run zsh-plugins.sh

# Prompt
zsh_config_run prompt.zsh

# MOTD
zsh_config_run fetch.zsh

# Keybinds for OSes like Arch
zsh_config_run keybinds.zsh

if type lsb_release > /dev/null; then
    TERMINAL_TITLE="$USER@$(hostname -f):$(lsb_release -i -s)"
else
    TERMINAL_TITLE="$USER@$(hostname -f)"
fi
#
# Set the terminal title with our distribution
set_terminal_title() {
    printf "\e]0;$TERMINAL_TITLE\a" 
}

autoload -U add-zsh-hook
add-zsh-hook precmd set_terminal_title

# VSCode Integration
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

autoload -Uz add-zsh-hook

function reset_broken_terminal () {
	printf '%b' '\e[0m\e(B\e)0\017\e[?5l\e7\e[0;0r\e8'
}

add-zsh-hook -Uz precmd reset_broken_terminal



# Profiler
zmodload zsh/zprof

# Vi mode
bindkey -v

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
compinit

# Stop Ctrl-S freezing the terminal
stty stop undef

# Path
zsh_config_run path.zsh

# Plugins
zsh_config_run zsh-plugins.sh

# Prompt
zsh_config_run starship.zsh

# MOTD
zsh_config_run fetch.zsh

# Keybinds for OSes like Arch
zsh_config_run keybinds.zsh

if type lsb_release > /dev/null; then
    TERMINAL_TITLE="$USER@$(hostname -f):$(lsb_release -i -s)"
else
    TERMINAL_TITLE="$USER@$(hostname -f)"
fi

# Set the terminal title with our distribution
set_terminal_title() {
    printf "\e]0;$TERMINAL_TITLE\a" 
}

autoload -U add-zsh-hook
add-zsh-hook precmd set_terminal_title

# Function to set the terminal title with the command being executed
preexec_set_terminal_title() {
    local cmd=$1; print -Pn "\e]0;$cmd ● $TERMINAL_TITLE\a"
}

add-zsh-hook preexec preexec_set_terminal_title


# VSCode Integration
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

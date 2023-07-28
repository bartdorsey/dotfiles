# Profiler
zmodload zsh/zprof

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

# Stop Ctrl-S freezing the terminal
stty stop undef

# Path
zsh_config_run path.zsh

# Plugins
zsh_config_run zsh-plugins.sh

# Prompt
zsh_config_run starship.zsh

# MOTD
zsh_config_run macchina.zsh

# Keybinds for OSes like Arch
zsh_config_run keybinds.zsh

# Run compinit
compinit

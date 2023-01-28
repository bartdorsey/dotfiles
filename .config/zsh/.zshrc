# Profiler
zmodload zsh/zprof
# Skip global compinit initialization in Ubuntu
skip_global_compinit=1
# Load zsh functions
source $ZDOTDIR/zsh-functions.sh
# Load Environment Variables

# Configure colors for zsh
autoload -U colors && colors

# Configure zmv
autoload zmv

# Configure completion for zsh
zsh_configure_completion > /dev/null 2>&1

# Stop Ctrl-S freezing the terminal
stty stop undef

# Plugins
zsh_config_run zsh-plugins.sh

# End Profiler
#zprof

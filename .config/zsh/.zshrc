# Skip global compinit initialization in Ubuntu
skip_global_compinit=1
# Load zsh functions
source $ZDOTDIR/zsh-functions.sh
# Load Environment Variables
zsh_config_run zsh-env.sh

# Configure colors for zsh
autoload -U colors && colors

# Configure zmv
autoload zmv

# Configure completion for zsh
zsh_configure_completion > /dev/null 2>&1

# Stop Ctrl-S freezing the terminal
stty stop undef

eval "`pip completion --zsh`"

# Node
zsh_config_run zsh-fnm.sh
zsh_config_run zsh-volta.sh
zsh_config_run zsh-pnpm.sh

# FZF
zsh_config_run zsh-fzf.sh

# WSL
zsh_config_run zsh-wsl2.sh

# NIX
zsh_config_run zsh-nix.sh

# Python
zsh_config_run zsh-python.sh

# SSH
zsh_config_run zsh-ssh.sh

# Aliases
zsh_config_run zsh-aliases.sh

# GRC Aliases
zsh_config_run zsh-grc-rs.sh

# Plugins
zsh_config_run zsh-plugins.sh

# Key binds
zsh_config_run zsh-binds.sh

# Zoxide
zsh_config_run zsh-zoxide.sh

# direnv
zsh_config_run zsh-direnv.sh

# Prompt
zsh_config_run zsh-starship.sh

# Macchina system info
zsh_config_run zsh-macchina.sh

# Helix setup
zsh_config_run zsh-helix.sh

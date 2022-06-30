# Load zsh functions
source $ZDOTDIR/zsh-functions.sh
# Load Environment Variables
zsh_config_run zsh-env.sh

# Configure colors for zsh
autoload -U colors && colors

# Configure completion for zsh
zsh_configure_completion

# Stop Ctrl-S freezing the terminal
stty stop undef

source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
eval "`pip completion --zsh`"
source /usr/share/autojump/autojump.sh
source /etc/grc.zsh

#zsh_config_run zsh-nvm.sh
# fnm
export PATH=$HOME/.fnm:$PATH
eval "`fnm env`"
zsh_config_run zsh-ssh.sh
zsh_config_run zsh-aliases.sh
zsh_config_run zsh-plugins.sh
zsh_config_run zsh-binds.sh

#code-quotes -c "#6600FF"


# Starship prompt
eval "$(starship init zsh)"

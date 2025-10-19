# Source common devtools
source $HOME/.config/common/devtools.sh


# Python
if command_exists pip3; then
    eval "`pip3 completion --zsh`"
fi

# Ruby
if command_exists rbenv; then
   eval "$(rbenv init - zsh)"
fi

# direnv
if command_exists direnv; then
    eval "$(direnv hook zsh)"
fi


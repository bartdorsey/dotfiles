# Mise
if command_exists mise; then
    eval "$(mise activate zsh)"
fi

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


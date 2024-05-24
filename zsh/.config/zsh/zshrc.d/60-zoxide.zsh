if type zoxide > /dev/null; then
    # Set exlude dirs for zoxide
    export _ZO_EXCLUDE_DIRS="$HOME/.cache/*"
    # Initialize zoxide
    eval "$(zoxide init --cmd cd zsh)"
    alias j=z
    alias z=cd
fi

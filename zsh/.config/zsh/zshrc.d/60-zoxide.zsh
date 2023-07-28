if type zoxide > /dev/null; then
    # Set exlude dirs for zoxide
    export _ZO_EXCLUDE_DIRS="$HOME/.cache/*"
    # Initialize zoxide
    eval "$(zoxide init zsh)"
    alias j=z
fi

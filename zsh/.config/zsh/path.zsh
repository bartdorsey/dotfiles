# Source common path
source $HOME/.config/common/path.sh

# Nodejs
if type fnm > /dev/null; then
    eval "$(fnm env --shell=zsh --use-on-cd)"
    if ! type node > /dev/null; then
        fnm install --lts
    fi
fi

# Zoxide
if type zoxide > /dev/null; then
    # Set exlude dirs for zoxide
    export _ZO_EXCLUDE_DIRS="$HOME/.cache/*"
    export _ZO_RESOLVE_SYMLINKS=1
    # Initialize zoxide
    eval "$(zoxide init --cmd cd zsh)"
    alias z=cd
fi

# GRC-RS
#if type grc-rs > /dev/null; then
#    eval $(grc-rs --aliases)
#fi

# GRC
if type grc > /dev/null; then
    source $ZDOTDIR/grc.zsh
fi


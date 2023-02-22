if ! type grc-rs > /dev/null; then
    cargo install grc-rs --locked
fi

if type grc-rs > /dev/null; then
    if [[ ! -e $ZDOTDIR/.grc-rs.zsh ]]; then
        grc-rs --aliases > $ZDOTDIR/.grc-rs.zsh 
    fi
    source $ZDOTDIR/.grc-rs.zsh
fi

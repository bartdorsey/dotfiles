if type grc-rs > /dev/null; then
    if [[ ! -e $ZDOTDIR/.grc-rs.zsh ]]; then
        grc-rs --aliases > $ZDOTDIR/.grc-rs.zsh 
    fi
    source $ZDOTDIR/.grc-rs.zsh
else
    echo "grc-rs missing."
fi

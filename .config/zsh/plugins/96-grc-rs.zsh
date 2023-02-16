if type grc-rs > /dev/null; then
    if [[ -e $ZDOTDIR/.grc-rs.zsh ]]; then
        source $ZDOTDIR/.grc-rs.zsh
    fi
else
    echo "grc-rs missing."
fi

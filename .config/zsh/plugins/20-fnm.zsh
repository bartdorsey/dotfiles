if type fnm > /dev/null; then
    eval "$(fnm env --shell=zsh --use-on-cd)"
    if ! type node > /dev/null; then
        fnm install --lts
    fi
fi


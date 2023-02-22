eval "$(fnm env --use-on-cd)"

if ! type node > /dev/null; then
    fnm install --lts
fi

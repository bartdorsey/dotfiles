if ! type fnm > /dev/null; then
    echo "Installing Fast Node Manager"
    cargo install fnm --locked
fi
eval "$(fnm env --use-on-cd)"

if ! type node > /dev/null; then
    fnm install --lts
fi

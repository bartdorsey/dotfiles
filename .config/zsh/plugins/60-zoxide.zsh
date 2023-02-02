if ! type zoxide > /dev/null; then
    cargo install zoxide --locked
fi
# Initialize zoxide
eval "$(zoxide init zsh)"

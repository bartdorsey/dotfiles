if ! type starship > /dev/null; then
    echo "Installing Starship Prompt"
    cargo install starship --locked
fi
# Starship prompt
eval "$(starship init zsh)"

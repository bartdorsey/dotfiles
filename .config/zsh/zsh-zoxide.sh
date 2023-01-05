if type zoxide > /dev/null; then
    # Initialize zoxide
    eval "$(zoxide init zsh)"
else
    echo "zoxide missing."
fi

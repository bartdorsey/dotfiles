if type direnv > /dev/null; then
    eval "$(direnv hook zsh)"
else
    echo "direnv missing."
fi

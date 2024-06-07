if type starship > /dev/null; then
    # Starship prompt
    eval "$(starship init zsh)"
elif type oh-my-posh > /dev/null; then
    eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/themes/rose-pine.omp.json)"
fi

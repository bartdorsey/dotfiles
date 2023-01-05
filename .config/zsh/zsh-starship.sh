if type starship > /dev/null; then
    # Starship prompt
    eval "$(starship init zsh)"
else
    echo "starship missing."
    # MacOS default prompt
    PS1="%n@%m %1~ %# "
fi
	

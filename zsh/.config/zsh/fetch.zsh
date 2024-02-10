if [[ "$TERM_PROGRAM" != "vscode" ]]; then
    if type fastfetch > /dev/null; then
        fastfetch
    elif type macchina > /dev/null; then
        macchina -t Catppuccin
    fi
fi

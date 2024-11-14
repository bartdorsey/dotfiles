if [[ "$TERM_PROGRAM" != "vscode" ]]; then
    if type fastfetch > /dev/null 2>&1; then
        fastfetch
    elif type macchina > /dev/null 2>&1; then
        macchina -t Catppuccin
    fi
fi

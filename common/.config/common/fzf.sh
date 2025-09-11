# FZF Config
if type fzf > /dev/null 2>&1; then
    FZF_COMMON_OPTS="--style=full"
    if type fdfind > /dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='fdfind --type f --color=never --hidden'
    elif type fd > /dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
    fi
    if type bat > /dev/null 2>&1; then
        export FZF_DEFAULT_OPTS="$FZF_COMMON_OPTS --preview='bat -p --color=always {}'"
    else
        export FZF_DEFAULT_OPTS='$FZF_COMMON_OPTS'
    fi
fi

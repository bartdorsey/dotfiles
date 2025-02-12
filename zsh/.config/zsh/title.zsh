set_terminal_title() {
    print -Pn "\e]0;$1\a"
}

set_tmux_title() {
    print -Pn "\033k$1\033\\"
}

autoload -U add-zsh-hook

preexec() {
    TERMINAL_TITLE="$1"
    if [[ -n "$SSH_CLIENT" ]]; then
        TERMINAL_TITLE="$TERMINAL_TITLE 󰣀 "
    fi
    set_terminal_title $TERMINAL_TITLE
}

precmd() {
    TERMINAL_TITLE="zsh [$(basename "$(dirname "$PWD")")/$(basename "$PWD")]"
    if [[ -n "$SSH_CLIENT" ]]; then
        TERMINAL_TITLE="$TERMINAL_TITLE 󰣀 "
    fi
    set_terminal_title $TERMINAL_TITLE
}

add-zsh-hook precmd precmd
add-zsh-hook preexec preexec

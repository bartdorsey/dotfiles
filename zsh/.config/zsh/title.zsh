set_terminal_title() {
    print -Pn "\e]0;$1\a"
}

autoload -U add-zsh-hook

preexec() {
    set_terminal_title "$1"
}

precmd() {
    set_terminal_title "zsh [$(basename "$(dirname "$PWD")")/$(basename "$PWD")]"
}

add-zsh-hook precmd precmd
add-zsh-hook preexec preexec

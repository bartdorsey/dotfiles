function _activate_venv() {
    if [[ -z "$VIRTUAL_ENV" ]] ; then
        ## If env folder is found then activate the vitualenv
        if [[ -d ./.venv ]] ; then
            echo "Activating Python Virtual Environment: $(basename $(pwd))/.venv"
            source ./.venv/bin/activate
        fi
    else
        ## check the current folder belong to earlier VIRTUAL_ENV folder
        # if yes then do nothing
        # else deactivate
        parentdir="$(dirname "$VIRTUAL_ENV")"
        if [[ "$PWD"/ != "$parentdir"/* ]] ; then
            echo "Deactivating Python Virtual Environment $(basename $parentdir)/.venv"
            deactivate
        fi
    fi
}

typeset -ag precmd_functions;
 if [[ -z "${precmd_functions[(r)_activate_venv]+1}" ]]; then
     precmd_functions=( _activate_venv ${precmd_functions[@]} )
 fi

 typeset -ag cdpwd_functions;
 if [[ -z "${cdpwd_functions[(r)_activate_venv]+1}" ]]; then
     cdpwd_functions=( _activate_venv ${cdpwd_functions[@]} )
 fi

function zsh_config_run(){
    zsh_config_run_file="$1"
    zsh_config_run_file_path="$ZDOTDIR/$zsh_config_run_file"
    if [ -f "$zsh_config_run_file_path" ]; then
        source "$zsh_config_run_file_path"
    fi
}

function zsh_configure_completion() {
    # Configure completion for zsh
    autoload -U compinit
    zstyle ':completion:*' menu no
    zstyle ':completion:*' verbose yes
    zstyle ':completion:*' list-dirs-first
    zstyle ':completion:*' list-grouped
    zstyle ':completion:*:descriptions' format '[%d]'
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --icon always $realpath'
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    #zstyle ':completion:*' format '%F{yellow}-- %d --%f'
    zstyle ':completion:*' complete-options true
    zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
    # partial completion suggestions
    zstyle ':completion:*' list-suffixes
    zstyle ':completion:*' expand prefix sufix
    zmodload zsh/complist
    compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
    _comp_options+=(globdots)
    unsetopt listambiguous
    setopt AUTO_LIST
    LISTMAX=-1
    # bun completions
    [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
}


function vmrss() {
    while true;
    do
        awk '/VmRSS:/ {print $2}' "/proc/$1/status";
        sleep 1;
    done;
}

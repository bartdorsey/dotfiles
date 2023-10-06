function cd() {
    builtin cd "$@"

    # if [[ -v WSL_DISTRO_NAME ]]; then
    #     export WSL_INTEROP=
    #     for socket in /run/WSL/*; do
    #         if ss -elx | grep -q "$socket"; then
    #             export WSL_INTEROP=$socket
    #         else
    #             rm -v $socket
    #         fi
    #     done
    #
    #     if [[ -z $WSL_INTEROP ]]; then
    #         echo -e "\033[31mNo working WSL_INTEROP socket found !\033[0m"
    #     fi
    # fi
    venv
}

function venv() {
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
    zstyle ':completion:*' menu select
    zstyle ':completion:*' verbose yes
    zstyle ':completion:*' file-list all
    zstyle ':completion:*' format '%F{yellow}-- %d --%f'
    zstyle ':completion:*' complete-options true
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

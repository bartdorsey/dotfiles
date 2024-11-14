# Python automatically activate venvs
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

# typeset -ag precmd_functions;
# if [[ -z "${precmd_functions[(r)_activate_venv]+1}" ]]; then
#     precmd_functions=( _activate_venv ${precmd_functions[@]} )
# fi
#
# typeset -ag cdpwd_functions;
# if [[ -z "${cdpwd_functions[(r)_activate_venv]+1}" ]]; then
#     cdpwd_functions=( _activate_venv ${cdpwd_functions[@]} )
# fi

# Install AUR packages
aurinstall() {
    local AURL="https://aur.archlinux.org/cgit/aur.git/snapshot/${1}.tar.gz"
    local WDIR="$(mktemp -d)"
    (cd "${WDIR}" && curl -Ofs "${AURL}" && tar -xzf "${1}.tar.gz" || {
        echo 'Package not found' 1>&2
        false
    }) && (cd "${WDIR}/${1}" && makepkg -sic)
    rm -rf "${WDIR}"
}

# VMRSS
function vmrss() {
    while true;
    do
        awk '/VmRSS:/ {print $2}' "/proc/$1/status";
        sleep 1;
    done;
}

# sesh
if command_exists sesh; then
    function sesh-sessions() {
      {
        exec </dev/tty
        exec <&1
        local session
        session=$(sesh list -i -c -t -z | gum filter --width=80 --reverse --height=10 --limit 1 --placeholder 'Pick a sesh' --prompt='⚡')
        # session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
        [[ -z "$session" ]] && return
        sesh connect $session
      }
    }

    zle -N sesh-sessions
    bindkey -M emacs '\es' sesh-sessions
    bindkey -M vicmd '\es' sesh-sessions
    bindkey -M viins '\es' sesh-sessions
fi

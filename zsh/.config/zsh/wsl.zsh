if [[ -v WSL_DISTRO_NAME ]]; then
    # Configure ssh forwarding
    #export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
    # need `ps -ww` to get non-truncated command for matching
    # use square brackets to generate a regex match for the process we want but that doesn't match the grep command running it!
    #ALREADY_RUNNING=$(ps -auxww | grep -q "[n]piperelay.exe -ei -s //./pipe/openssh-ssh-agent"; echo $?)
    #if [[ $ALREADY_RUNNING != "0" ]]; then
    #   if [[ -S $SSH_AUTH_SOCK ]]; then
    #      # not expecting the socket to exist as the forwarding command isn't running (http://www.tldp.org/LDP/abs/html/fto.html)
    #      echo "removing previous socket..."
    #      rm $SSH_AUTH_SOCK
    #   fi
    #   echo "Starting SSH-Agent relay..."
    #   # setsid to force new session to keep running
    #   # set socat to listen on $SSH_AUTH_SOCK and forward to npiperelay which then forwards to openssh-ssh-agent on windows
    #   (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
    #fi

    # export WSL_INTEROP=
    # for socket in /run/WSL/*; do
    #     if ss -elx | grep -q "$socket"; then
    #         export WSL_INTEROP=$socket
    #     else
    #         rm -v $socket
    #     fi
    # done
    #
    # if [[ -z $WSL_INTEROP ]]; then
    #     echo -e "\033[31mNo working WSL_INTEROP socket found !\033[0m"
    # fi

    # WSL aliases
    alias clip='/mnt/c/Windows/system32/clip.exe'
    alias open='/mnt/c/Windows/explorer.exe'
    alias wsl='/mnt/c/Windows/system32/wsl.exe'
    alias pwsh='/mnt/c/Program\ Files/PowerShell/7/pwsh.exe'
    alias neovide="/mnt/c/Users/bart/scoop/apps/neovide/current/neovide.exe --wsl --"

    code() {
      /mnt/c/Users/bart/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code "$@"
    }

    if [ -d "/mnt/c/Users/bart/AppData/Local/Programs/cursor" ]; then 
        function cursor {
            DONT_PROMPT_WSL_INSTALL=1 /mnt/c/Users/bart/AppData/Local/Programs/cursor/Cursor.exe --remote wsl+default $1
        }
    fi

    notify-send() { wsl-notify-send.exe --category $WSL_DISTRO_NAME "${@}"; }
fi

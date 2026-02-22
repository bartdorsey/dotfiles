if [[ -v WSL_DISTRO_NAME ]]; then
    # export GPG_AGENT_SOCK="/run/user/1000/gnupg/d.9yfkc3bkj8nfdmckpq61pgou/S.gpg-agent"
    # ss -a | grep -q "$GPG_AGENT_SOCK"
    # if ! ss -a | grep -q "$GPG_AGENT_SOCK"; then
      # rm -rfv "$GPG_AGENT_SOCK"
      # wsl2_ssh_pageant_bin="/mnt/c/Users/bart/Apps/wsl2-ssh-pageant.exe"
      # if test -x "$wsl2_ssh_pageant_bin"; then
      #     echo "Starting socat"
      #   /usr/bin/socat UNIX-LISTEN:"$GPG_AGENT_SOCK,fork" EXEC:"$wsl2_ssh_pageant_bin -gpg S.gpg-agent -gpgConfigBasepath C\:/Users/bart/AppData/Local/gnupg" &
      # else
      #   echo >&2 "WARNING: $wsl2_ssh_pageant_bin is not executable."
      # fi
      # unset wsl2_ssh_pageant_bin
    # else
    #     echo "No $GPG_AGENT_SOCK"
    # fi
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
    # alias clip='/mnt/c/Windows/system32/clip.exe'
    alias open='/mnt/c/Windows/explorer.exe'
    alias wsl='/mnt/c/Windows/system32/wsl.exe'
    alias pwsh='/mnt/c/Program\ Files/PowerShell/7/pwsh.exe'
    alias neovide="/mnt/c/Users/bart/scoop/apps/neovide/current/neovide.exe --wsl --neovim-bin /home/echo/.local/share/mise/installs/neovim/latest/nvim-linux-x86_64/bin/nvim --"

    code() {
      /mnt/c/Users/bart/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code "$@"
    }

    # if [ -d "/mnt/c/Users/bart/AppData/Local/Programs/cursor" ]; then
    #     function cursor {
    #         DONT_PROMPT_WSL_INSTALL=1 /mnt/c/Users/bart/AppData/Local/Programs/cursor/Cursor.exe --remote wsl+default $1
    #     }
    # fi

    notify-send() { wsl-notify-send.exe --category $WSL_DISTRO_NAME "${@}"; }

    # export PATH="/mnt/c/Windows:$PATH"
    # export PATH="/mnt/c/Windows/System32:$PATH"
    # export PATH="/mnt/c/Users/bart/AppData/Local/Programs/Microsoft VS Code/bin:$PATH"
    # export PATH="/mnt/c/Program Files/PowerShell/7:$PATH"
    # export PATH="/mnt/c/Users/bart/scoop/apps/gpg4win/current/GnuPG/bin:$PATH"
    # export PATH="/mnt/c/Windows/System32/WindowsPowerShell/v1.0:$PATH"
    # export PATH="/mnt/c/Users/bart/AppData/Local/Programs/Zed/bin:$PATH"
    export BROWSER="/mnt/c/Program Files/PowerShell/7/pwsh.exe -noni -nop -c start"

    export DISPLAY=:0
fi

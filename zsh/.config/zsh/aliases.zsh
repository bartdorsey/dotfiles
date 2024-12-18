# Git worktree
if command_exists git; then
    alias wt="git worktree"
fi

# Misc
alias ll="ls -al"

# Color Grep
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# eza - fancy ls
if command_exists eza; then
    alias ls="eza -g --icons --git -F -h --group-directories-first --octal-permissions"
fi

if command_exists lsd; then
    alias ls="lsd --group-directories-first -g"
fi

# lazygit
if type lazygit > /dev/null;then
    alias lg=lazygit
fi

# lazydocker
if command_exists lazydocker; then
    alias lzd=lazydocker
fi


if type xdg-open > /dev/null; then
    alias open=xdg-open
fi

if type wsl-open > /dev/null; then
    alias open=wsl-open
fi

# gitignore
function gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;}

# Buku search
if command_exists buku; then
    function bs() {
        xdg-open $(buku -p -f 40 | fzf -e | cut -f1)
    }
fi

# gh copilot
if command_exists gh; then
    eval "$(gh copilot alias -- zsh)"
fi

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

# wget
if command_exists wget; then
    alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
fi

# irssi
if command_exists irssi; then
    alias irssi=irssi --config="$XDG_CONFIG_HOME"/irssi/config --home="$XDG_DATA_HOME"/irssi
fi

# nvidia-settings
if type nvidia-settings > /dev/null; then
    alias nvidia-settings=nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings
fi

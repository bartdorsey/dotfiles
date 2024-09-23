# Git worktree
if type git > /dev/null; then
    alias wt="git worktree"
fi

# Misc
alias ll="ls -al"

# Color Grep
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# eza - fancy ls
if type eza > /dev/null; then
    alias ls="eza -g --icons --git -F -h --group-directories-first --octal-permissions"
fi

if type lsd > /dev/null; then
    alias ls="lsd --group-directories-first -g"
fi

# lazygit
if type lazygit > /dev/null;then
    alias lg=lazygit
fi

# lazydocker
if type lazydocker > /dev/null; then
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
if type buku > /dev/null; then
    function bs() {
        xdg-open $(buku -p -f 40 | fzf -e | cut -f1)
    }
fi

# gh copilot
if type gh > /dev/null; then
    eval "$(gh copilot alias -- zsh)"
fi

# sesh
if type sesh > /dev/null; then

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
if type wget > /dev/null; then
    alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
fi

# irssi
if type irssi > /dev/null; then
    alias irssi=irssi --config="$XDG_CONFIG_HOME"/irssi/config --home="$XDG_DATA_HOME"/irssi
fi

# nvidia-settings
if type nvidia-settings > /dev/null; then
    alias nvidia-settings=nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings
fi
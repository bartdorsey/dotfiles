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
else
    alias ls='ls --color=auto'
fi

# lazygit
if command_exists lazygit; then
    alias lg=lazygit
fi

# lazydocker
if command_exists lazydocker; then
    alias lzd=lazydocker
fi


if command_exists xdg-open; then
    alias open=xdg-open
fi

if command_exists wsl-open; then
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

# wget
if command_exists wget; then
    alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
fi

# irssi
if command_exists irssi; then
    alias irssi=irssi --config="$XDG_CONFIG_HOME"/irssi/config --home="$XDG_DATA_HOME"/irssi
fi

# nvidia-settings
if command_exists nvidia-settings; then
    alias nvidia-settings=nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings
fi

if command_exists superfile; then
    alias spf=superfile
fi

if command_exists vim; then
    alias vi=$(which vim)
fi

if command_exists nvim;then
    alias vim=$(which nvim)
fi

if command_exists systemctl; then
    alias sctl='systemctl --no-lengend --plain'
    alias sls='systemctl list-units --all --type=service --no-legend --plain'
    alias sus='systemctl list-units --all --user --type=service --no-legend --plain'
fi

# Zoxide
if command_exists zoxide; then
    # Set exlude dirs for zoxide
    export _ZO_EXCLUDE_DIRS="$HOME/.cache/*"
    # Initialize zoxide
    if [ -n "$ZSH_VERSION" ]; then
        eval "$(zoxide init --cmd cd zsh)"
    else
        eval "$(zoxide init --cmd cd bash)"
    fi
    alias j=z
    alias z=cd
fi

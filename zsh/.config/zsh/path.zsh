# local bin
if [ -d /usr/local/bin ]; then
    export PATH="/usr/local/bin:$PATH"
fi

# Linux brew
if [ -d /home/linuxbrew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi


# Homebrew
if [ -d "/opt/homebrew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi


# Bob
if type bob > /dev/null; then
    if [ -d "$HOME/.local/share/bob/nvim-bin" ];then
        export PATH=$HOME/.local/share/bob/nvim-bin:$PATH
    fi
fi

# Local bin
if [ -d "$HOME/.local/bin" ];then
    export PATH=$HOME/.local/bin:$PATH:
fi

# Nvim tarball
if [ -d /opt/nvim-linux64/bin ];then
    export PATH="/opt/nvim-linux64/bin:$PATH"
fi


# Wezterm Windows
if [ -f "/mnt/c/Users/bart/scoop/apps/wezterm-nightly/current/wezterm.exe" ];then
    export PATH="/mnt/c/Users/bart/scoop/apps/wezterm-nightly/current:$PATH"
fi

# Nodejs
if type fnm > /dev/null; then
    eval "$(fnm env --shell=zsh --use-on-cd)"
    if ! type node > /dev/null; then
        fnm install --lts
    fi
fi

# Zoxide
if type zoxide > /dev/null; then
    # Set exlude dirs for zoxide
    export _ZO_EXCLUDE_DIRS="$HOME/.cache/*"
    # Initialize zoxide
    eval "$(zoxide init --cmd cd zsh)"
    alias j=z
    alias z=cd
fi

# nvim
alias vi=$(which vim)

if type nvim > /dev/null;then
    alias vim=$(which nvim)
    alias nvchad="VIMINIT= NVIM_APPNAME=nvchad nvim"
    alias butts="VIMINIT= NVIM_APPNAME=alphakeks nvim"
fi

# 1Password
if type op > /dev/null; then
   function 1p {
      op item get $(op item list | fzf | cut -f 1 -d " ")
   }
fi

# GRC-RS
#if type grc-rs > /dev/null; then
#    eval $(grc-rs --aliases)
#fi

# GRC
if type grc > /dev/null; then
    source $ZDOTDIR/grc.zsh
fi


# local bin
if [ -d /usr/local/bin ]; then
    export PATH="/usr/local/bin:$PATH"
fi

# Linux brew
if ! command_exists nix; then
    if [ -d /home/linuxbrew ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
fi

# Homebrew
if [ -d "/opt/homebrew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi


# Bob
if command_exists bob; then
    if [ -d "$HOME/.local/share/bob/nvim-bin" ];then
        export PATH=$HOME/.local/share/bob/nvim-bin:$PATH
    fi
fi

# Local bin
if [ -d "$HOME/.local/bin" ];then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Local scripts
if [ -d "$HOME/.local/scripts" ]; then
    export PATH="$HOME/.local/scripts:$PATH"
fi

# Nvim tarball
if [ -d /opt/nvim-linux64/bin ];then
    export PATH="/opt/nvim-linux64/bin:$PATH"
fi

# Wezterm Windows
if [ -f "/mnt/c/Users/bart/scoop/apps/wezterm-nightly/current/wezterm.exe" ];then
    export PATH="/mnt/c/Users/bart/scoop/apps/wezterm-nightly/current:$PATH"
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

# nvim
if command_exists vim; then
    alias vi=$(which vim)
fi

if command_exists nvim;then
    alias vim=$(which nvim)
    alias nvchad="VIMINIT= NVIM_APPNAME=nvchad nvim"
    alias butts="VIMINIT= NVIM_APPNAME=alphakeks nvim"
fi

# 1Password
if command_exists op; then
   function 1p {
      op item get $(op item list | fzf | cut -f 1 -d " ")
   }
fi

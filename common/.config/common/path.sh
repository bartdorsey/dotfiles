# local bin
if [ -d /usr/local/bin ]; then
    export PATH="/usr/local/bin:$PATH"
fi

# Mason's bin path
if [ -d "$HOME/.local/share/nvim/mason/bin" ]; then
    export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
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

if [ -d /opt/nvim-linux-x86_64/bin ];then
    export PATH="/opt/nvim-linux-x89_64/bin:$PATH"
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

# 1Password
if command_exists op; then
   function 1p {
      op item get $(op item list | fzf | cut -f 1 -d " ")
   }
fi

if [ -d "$HOME/.config/emacs/bin" ]; then
    export PATH="$HOME/.config/emacs/bin:$PATH"
fi

# Flatpak
if command_exists flatpak; then
    export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
fi


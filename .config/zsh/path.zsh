# Rust
if [ -d "$HOME/.cargo/bin" ];then
    export PATH=$HOME/.cargo/bin:$PATH:
fi

# t script
if [ -d $HOME/.tmux/plugins/t-smart-tmux-session-manager ];then
    export PATH=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
fi

# Go
if [ -d "$HOME/go" ];then
    export PATH=$PATH:~/go/bin
fi

# BUN
if [ -d "$HOME/.bun" ]; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
fi

# Homebrew
if [ -d "/opt/homebrew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Bob
if [ -d "$HOME/.local/share/bob/nvim-bin" ];then
    export PATH=$HOME/.local/share/bob/nvim-bin:$PATH
fi

# Local bin
if [ -d "$HOME/.local/bin" ];then
    export PATH=$HOME/.local/bin:$PATH:
fi

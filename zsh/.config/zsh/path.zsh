# Rust
if [ -d "$CARGO_HOME/bin" ];then
    export PATH=$CARGO_HOME/bin:$PATH:
fi

# t script
if [ -d $HOME/.tmux/plugins/t-smart-tmux-session-manager ];then
    export PATH=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
fi

# Haskell
if [ -d $HOME/.ghcup ];then
    export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
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

# GO
if type go > /dev/null; then
    export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"
fi

# Bob
if [ -d "$HOME/.local/share/bob/nvim-bin" ];then
    export PATH=$HOME/.local/share/bob/nvim-bin:$PATH
fi

# Local bin
if [ -d "$HOME/.local/bin" ];then
    export PATH=$HOME/.local/bin:$PATH:
fi

# Nvim tarball
if [ -d /opt/nvim-linux64/bin ];then
    export PATH="/opt/nvim-linux64/bin:$PATH"
fi

# Perl
if [ -d "$HOME/perl5" ]; then
    export PERL5LIB="$HOME/perl5/lib/perl5"
    export PATH="$HOME/perl5/bin:$PATH"
fi

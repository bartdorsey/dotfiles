# local bin
if [ -d /usr/local/bin ]; then
    export PATH="/usr/local/bin:$PATH"
fi

# Docker Desktop
if [ -d "$HOME/.docker/bin" ]; then
    export PATH="$HOME/.docker/bin:$PATH"
fi

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

# Perl
if [ -d "$HOME/perl5" ]; then
    export PERL5LIB="$HOME/perl5/lib/perl5"
    export PATH="$HOME/perl5/bin:$PATH"
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

# Ocaml
[[ ! -r $HOME/.local/share/opam/opam-init/init.zsh ]] || source $HOME/.local/share/opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# pnpm
if type pnpm > /dev/null;then
    export PNPM_HOME="$HOME/.local/share/pnpm"
    export PATH="$PNPM_HOME:$PATH"
fi

# Python
if type pip3 > /dev/null; then
    eval "`pip3 completion --zsh`"
fi

if type python3 > /dev/null; then
    # Python Virtual Environment stuff
    alias python=python3
    alias pip=pip3
    alias venv="python -m venv .venv && source .venv/bin/activate"
    alias activate="source .venv/bin/activate"
fi

# Ruby
if type rbenv > /dev/null; then
   eval "$(rbenv init - zsh)"
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

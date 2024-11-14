# Docker Desktop
if [ -d "$HOME/.docker/bin" ]; then
    export PATH="$HOME/.docker/bin:$PATH"
fi

# Rust
if [ -d "$CARGO_HOME/bin" ];then
    export PATH=$CARGO_HOME/bin:$PATH:
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

# Deno
if [ -f "$HOME/.deno" ]; then
    . "/home/echo/.deno/env"
fi

# GO
if command_exists go; then
    export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"
fi

# Perl
if [ -d "$HOME/perl5" ]; then
    export PERL5LIB="$HOME/perl5/lib/perl5"
    export PATH="$HOME/perl5/bin:$PATH"
fi

# Ocaml
# [[ ! -r $HOME/.local/share/opam/opam-init/init.zsh ]] || source $HOME/.local/share/opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# pnpm
if command_exists pnpm;then
    export PNPM_HOME="$HOME/.local/share/pnpm"
    export PATH="$PNPM_HOME:$PATH"
fi

# Python
if command_exists python3; then
    # Python Virtual Environment stuff
    alias python=python3
    alias pip=pip3
    alias venv="python -m venv .venv && source .venv/bin/activate"
    alias activate="source .venv/bin/activate"
fi

# PHP Laravel Herd
if [ -d "$HOME/.config/herd-lite" ]; then
    export PATH="$HOME/.config/herd-lite/bin:$PATH"
fi

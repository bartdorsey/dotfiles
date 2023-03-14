if [-d "$HOME/.nix-profile/share/go" ]; then
    export PATH="$HOME/.nix-profile/share/go/bin/:$PATH"
    export GOROOT="$HOME/.nix-profile/share/go/"
fi


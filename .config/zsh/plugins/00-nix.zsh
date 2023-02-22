if ! type nix-env > /dev/null; then 
   sh <(curl -L https://nixos.org/nix/install) --daemon
fi

if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then 
   . $HOME/.nix-profile/etc/profile.d/nix.sh;
fi # added by Nix installer

# Install tmux
if ! type tmux > /dev/null; then
   nix-env -iA nixpkgs.tmux
fi

# Install neovim
if ! type nvim > /dev/null; then
   nix-env -iA nixpkgs.neovim
fi

# Install starship
if ! type starship > /dev/null; then
   nix-env -iA nixpkgs.starship
fi

# Install fnm
if ! type fnm > /dev/null; then
   nix-env -iA nixpkgs.fnm
fi

# Install fzf
if ! type fzf > /dev/null; then
   nix-env -iA nixpkgs.fzf
fi

# Install go
if ! type go > /dev/null; then
   nix-env -iA nixpkgs.go
fi

# Install rustup
if ! type rustup > /dev/null; then
   nix-env -iA nixpkgs.rustup
fi

# Install zoxide
if ! type zoxide > /dev/null; then
   nix-env -iA nixpkgs.zoxide
fi

# Install direnv
if ! type direnv > /dev/null; then
    nix-env -iA nixpkgs.direnv
fi

# Install exa
if ! type exa > /dev/null; then
    nix-env -iA nixpkgs.exa
fi

# Install macchina
if ! type macchina > /dev/null; then
   nix-env -iA nixpkgs.macchina
fi

# Install bat
if ! type bat > /dev/null; then
   nix-env -iA nixpkgs.bat
fi

# Install lazygit
if ! type lazygit > /dev/null; then
   nix-env -iA lazygit
fi

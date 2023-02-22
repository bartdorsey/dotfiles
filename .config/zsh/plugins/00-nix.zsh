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

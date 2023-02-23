if [ ! -e /nix ]; then 
   sh <(curl -L https://nixos.org/nix/install) --daemon
fi

if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then 
   . $HOME/.nix-profile/etc/profile.d/nix.sh;
fi # added by Nix installer


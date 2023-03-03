export XDG_CONFIG_HOME="$HOME/.config"
ZDOTDIR=$HOME/.config/zsh
skip_global_compinit=1
if [ -e /home/echo/.nix-profile/etc/profile.d/nix.sh ]; then . /home/echo/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer


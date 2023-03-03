echo $PATH
if [ ! -e /nix ]; then 
   sh <(curl -L https://nixos.org/nix/install) --daemon
fi

export GRC_ALIASES=true

if [ -e $HOME/.nix-profile/etc/profile.d/grc.sh ]; then
   . $HOME/.nix-profile/etc/profile.d/grc.sh
fi

if [ -d $HOME/.nix-profile/etc/profile.d ] ; then
   for i in $HOME/.nix-profile/etc/profile.d/*.sh; do
      echo $i
      if [ -r $i ]; then
         . $i
      fi
   done
fi

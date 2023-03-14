if [ ! -e /nix ]; then 
   sh <(curl -L https://nixos.org/nix/install) --daemon
fi

if type grc > /dev/null;then
    export GRC_ALIASES=true
fi

if [ -d $HOME/.nix-profile/etc/profile.d ] ; then
   for i in $HOME/.nix-profile/etc/profile.d/*.sh; do
      if [ -r $i ]; then
         . $i
      fi
   done
fi

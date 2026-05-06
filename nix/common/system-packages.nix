{
  pkgs,
  pkgs-unstable,
  ...
}: {
  environment.systemPackages =
    (with pkgs; [
       # Terminal / CLI utilities
       bat
       dust
       fd
       file
       fzf
       grc
       lsd
       ripgrep
       tree

      # Shell tools
      gum
      starship
      zoxide
      zsh

      # File managers
      mc
      superfile
      yazi

      # Archival
      p7zip
      unzip
      zip

      # System monitors
      btop
      htop
      procs
      systemctl-tui
      sysz

      # Networking
      curl
      curlie
      dig
      mosh
      mtr
      wget
      xh

      # Nix tools
      nh
      nix-output-monitor
      nix-search-cli
      nvd
      optinix
      optnix

      # Audio / Music
      mpc
      mpdris2
      ncmpcpp
      pulseaudio
      pulseaudio-ctl
      pulsemixer
      rmpc
      vimpc

      # Calendar / Bookmarks
      buku
      khal

      # Media
      ffmpeg
      yt-dlp

      # Backup / Sync
      restic
      resticprofile
      syncthing

      # Storage / File sharing
      cifs-utils
      nfs-utils
      samba
      socat

      # Security / Encryption
      gnupg
      pass
      pinentry-curses
      sbctl
      yubikey-personalization

      # Boot / System management
      efibootmgr
      kmod
      lsb-release
      mokutil
      os-prober
      parted
      refind

      # Desktop utilities
      trash-cli
      xdg-desktop-portal-termfilechooser
      xdg-utils
      zenity

      # Hardware info
      pciutils
      usbutils

      # System info
      fastfetch

      # Terminal multiplexer
      tmux
      vtm
      zellij

      # Dotfile management
      stow

      # Emulator
      vice

      # LaTeX
      texlive.combined.scheme-full
    ])
    ++ (with pkgs-unstable; [
      cryptsetup
    ]);
}

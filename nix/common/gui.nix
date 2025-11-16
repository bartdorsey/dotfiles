{
  pkgs,
  pkgs-unstable,
  lib,
  zen-browser,
  system,
  ...
}: {
  services.displayManager = {
    defaultSession = "hyprland-uwsm";
    ly = {
      enable = false;
    };
    sddm = {
      enable = false;
      wayland.enable = true;
    };
    cosmic-greeter.enable = false;
  };

  services.xserver = {
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      startx.enable = false;
      lightdm.enable = false;
    };
    enable = true;
    dpi = 96;

    windowManager.awesome = {
      enable = false;
      luaModules = with pkgs.luaPackages; [
        luarocks
        luadbi-mysql
      ];
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs-unstable.i3-rounded;
      extraPackages = with pkgs-unstable; [
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
        polybarFull
        xscreensaver
        lxappearance
      ];
    };
  };
  programs.uwsm = {
    enable = true;
  };

  programs.streamcontroller.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  services.autorandr.enable = true;

  programs.zoom-us.enable = false;

  services.desktopManager = {
    cosmic.enable = false;
    plasma6.enable = false;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.kdeconnect.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.xserver.upscaleDefaultCursor = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages =
    [zen-browser.packages."${system}".default]
    ++ (with pkgs-unstable; [
      firefoxpwa
      wezterm
    ])
    ++ (with pkgs; [
      _1password-cli
      _1password-gui
      adwaita-icon-theme
      appimage-run
      cava
      chromium
      cliphist
      clipman
      darktable
      desktop-file-utils
      dex
      discord
      dmenu #application launcher most people use
      dunst
      dust
      feh
      flameshot
      ghostty
      gimp
      glib
      gnome-software
      gnome-tweaks
      gparted
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-panel
      google-chrome
      grim
      grimblast
      kitty
      libnotify
      lora
      lxappearance
      maim
      mpv
      neovide
      networkmanagerapplet
      nh
      nix-output-monitor
      nvd
      obs-studio
      obsidian
      pavucontrol
      pcmanfm
      picom-pijulius
      plattenalbum
      playerctl
      plexamp
      qutebrowser
      rofi
      slack
      slurp
      syncthingtray
      terminus_font_ttf
      vesktop
      vieb
      vivaldi
      vlc
      vscode
      waybar
      wayland-utils # Wayland utilities
      wl-clipboard # Command-line copy/paste utilities for Wayland
      wttrbar
      wofi
      wtype
      xorg.xhost
      xss-lock
    ]);

  services.udev.packages = with pkgs; [
    gnome-settings-daemon
    gnome2.GConf
  ];

  # Vivaldi stuff
  nixpkgs.config = {
    vivaldi = {
      proprietaryCodecs = true;
      enableWideView = true;
    };
  };

  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";

  fonts = {
    fontconfig = {
      antialias = true;
      hinting.enable = true;
      hinting.autohint = true;
      hinting.style = "full";
    };
    enableDefaultPackages = true;
    packages = with pkgs; [
      corefonts
      vista-fonts
      nerd-fonts.iosevka
      nerd-fonts.symbols-only
    ];
  };

  programs.firefox = {
    enable = true;
    package = pkgs-unstable.firefox;
    nativeMessagingHosts.packages = [pkgs-unstable.firefoxpwa];
  };

  # Thunar
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  programs.xfconf.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  services.dbus.packages = with pkgs; [
    xfce.xfconf
  ];

  nix.settings = {
    substituters = ["https://wezterm.cachix.org"];
    trusted-public-keys = ["wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="];
  };
}

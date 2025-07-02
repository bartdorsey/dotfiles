{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: {
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  services.xserver.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  services.autorandr.enable = true;

  services.xserver = {
    dpi = 96;
    desktopManager = {
      xterm.enable = true;
    };

    windowManager.awesome = {
      enable = true;
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

  programs.streamdeck-ui = {
    enable = true;
    autoStart = true; # optional
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };
  programs.waybar = {
    enable = true;
  };
  services.flatpak.enable = true;

  services.desktopManager = {
    cosmic.enable = true;
    plasma6.enable = true;
  };

  services.displayManager = {
    defaultSession = "hyprland-uwsm";
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    cosmic-greeter.enable = false;
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
    (with pkgs-unstable; [
      firefoxpwa
    ])
    ++ (with pkgs; [
      _1password-cli
      _1password-gui
      adwaita-icon-theme
      appimage-run
      catppuccin-kde
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
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-panel
      google-chrome
      grim
      grimblast
      hypridle
      hyprlock
      hyprpaper
      hyprpolkitagent
      hyprshot
      kitty
      libnotify
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
      terminus_font_ttf
      vesktop
      vieb
      vivaldi
      vlc
      vscode
      waybar
      wayland-utils # Wayland utilities
      wezterm
      wl-clipboard # Command-line copy/paste utilities for Wayland
      wofi
      wtype
      xfce.thunar
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

  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  programs.firefox = {
    enable = true;
    package = pkgs-unstable.firefox;
    nativeMessagingHosts.packages = [pkgs-unstable.firefoxpwa];
  };
}

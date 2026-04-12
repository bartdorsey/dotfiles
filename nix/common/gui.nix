{
  pkgs,
  pkgs-unstable,
  lib,
  zen-browser,
  system,
  ...
}: {
  # programs.uwsm = {
  #   enable = true;
  # };

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

  programs.zoom-us.enable = true;

  programs.localsend = {
    enable = true;
    openFirewall = true;
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

  programs.chromium = {
    enable = true;
    extraOpts = {
      "WebAppInstallForceList" = [
        {
          "url" = "https://www.youtube.com";
          "custom_name" = "YouTube";
          "default_launch_container" = "window";
          "create_desktop_shortcut" = true;
        }
      ];
    };
  };

  environment.systemPackages =
    [zen-browser.packages."${system}".default]
    ++ (with pkgs-unstable; [
      firefoxpwa
      zed-editor-fhs
      vscode
      _1password-gui
      rustdesk-flutter
      fastmail-desktop
      modrinth-app
    ])
    ++ (with pkgs; [
      _1password-cli
      appimage-run
      bambu-studio
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
      gparted
      gnome-tweaks
      google-chrome
      grim
      grimblast
      gruvbox-dark-icons-gtk
      gruvbox-plus-icons
      libnotify
      lora
      maim
      mpv
      neovide
      networkmanagerapplet
      nh
      nix-output-monitor
      nvd
      nwg-displays
      obs-studio
      obsidian
      orca-slicer
      pavucontrol
      plattenalbum
      playerctl
      plexamp
      podman-desktop
      qutebrowser
      rofi
      signal-desktop
      slack
      slurp
      syncthingtray
      terminus_font_ttf
      thunderbird
      v4l-utils
      vesktop
      vice
      vivaldi
      vlc
      wayland-utils # Wayland utilities
      wl-clipboard # Command-line copy/paste utilities for Wayland
      wttrbar
      wofi
      wtype
      xorg.xhost
      xss-lock
    ]);

  # services.udev.packages = with pkgs; [
  #   gnome-settings-daemon
  #   gnome2.GConf
  # ];

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
      subpixel.rgba = "rgb";
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        monospace = ["Iosevka"];
      };
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
          <match target="pattern">
            <edit name="dpi" mode="assign">
            <double>163</double>
            </edit>
          </match>
        </fontconfig>
      '';
    };
    enableDefaultPackages = true;
    packages = with pkgs; [
      liberation_ttf
      ubuntu-classic
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

  # services.dbus.packages = with pkgs; [
  #   xfce.xfconf
  # ];

  nix.settings = {
    substituters = ["https://wezterm.cachix.org"];
    trusted-public-keys = ["wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="];
  };
}

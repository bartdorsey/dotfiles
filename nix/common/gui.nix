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

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  services.flatpak.enable = true;

  services.desktopManager = {
    cosmic.enable = true;
    plasma6.enable = true;
  };

  services.displayManager = {
    defaultSession = "none+i3";
    sddm = {
      enable = true;
    };
    cosmic-greeter.enable = false;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

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

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    desktop-file-utils
    dex
    dmenu #application launcher most people use
    dunst
    feh
    gnomeExtensions.appindicator
    gnome-software
    goxlr-utility
    lxappearance
    libnotify
    maim
    pavucontrol
    picom-pijulius
    terminus_font_ttf
    networkmanagerapplet
    waybar
    hyprpaper
    hyprlock
    hypridle
    hyprshot
    wofi
    xss-lock
  ];

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
}

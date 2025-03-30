{
  pkgs,
  pkgs-unstable,
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

  services.xserver.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.xserver.upscaleDefaultCursor = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    dex
    dmenu #application launcher most people use
    dunst
    feh
    gnomeExtensions.appindicator
    goxlr-utility
    lxappearance
    maim
    nerdfonts
    picom-pijulius
    networkmanagerapplet
    waybar
    hyprpaper
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

  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";
}

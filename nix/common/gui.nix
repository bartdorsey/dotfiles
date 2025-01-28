{
  pkgs,
  pkgs-unstable,
  ...
}: {
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  services.xserver.enable = true;

  services.xserver = {
    desktopManager = {
      xterm.enable = true;
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs-unstable.i3-rounded;
      extraPackages = with pkgs-unstable; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
        polybarFull
        feh
        lxappearance
        networkmanagerapplet
        goxlr-utility
        dunst
        picom
        maim
        dex
        xss-lock
      ];
    };
  };

  services.xserver.displayManager.lightdm = {
    enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

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
    gnomeExtensions.appindicator
    adwaita-icon-theme
  ];

  services.udev.packages = with pkgs; [
    gnome-settings-daemon
    gnome2.GConf
  ];
}

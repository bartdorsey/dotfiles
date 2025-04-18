{
  pkgs,
  pkgs-unstable,
  ...
}: {
  # My user account, with gui specific packages
  users.users.echo = {
    extraGroups = ["networkmanager" "wheel" "docker" "audio"];
    packages =
      (with pkgs-unstable; [
        zoom-us
        dust
        nh
        nix-output-monitor
        nvd
        _1password-gui
        _1password-cli
        firefox
        firefoxpwa
        ghostty
      ])
      ++ (with pkgs; [
        appimage-run
        catppuccin-kde
        chromium
        darktable
        discord
        flameshot
        gimp
        glib
        gnome-tweaks
        gnomeExtensions.dash-to-panel
        google-chrome
        kitty
        libsForQt5.lightly
        libsForQt5.xdg-desktop-portal-kde
        microsoft-edge
        neovide
        obs-studio
        qutebrowser
        rofi
        slack
        vesktop
        vieb
        vivaldi
        vscode
        wezterm
      ]);
  };
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-kde
    ];
    config.common.default = "*";
  };

  # Default applications
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "wezterm.desktop"
      ];
    };
  };

  xdg.mime.defaultApplications = {
    "inode/directory" = "yazi.desktop";
    "inode/mount-point" = "yazi.desktop";
  };
}

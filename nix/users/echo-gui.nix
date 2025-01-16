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
        firefox-devedition
      ])
      ++ (with pkgs; [
        vieb
        vivaldi
        libsForQt5.lightly
        libsForQt5.xdg-desktop-portal-kde
        chromium
        flameshot
        obs-studio
        discord
        slack
        google-chrome
        gnome-tweaks
        gnomeExtensions.dash-to-panel
        vscode
        wezterm
        kitty
        vesktop
        darktable
        rofi
        microsoft-edge
      ]);
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

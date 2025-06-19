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
        ])
      ++ (with pkgs; [
        dust
        nh
        nix-output-monitor
        nvd
        _1password-gui
        _1password-cli
        ghostty
        appimage-run
        catppuccin-kde
        chromium
        darktable
        discord
        flameshot
        gimp
        grimblast
        grim
        slurp
        glib
        gnome-tweaks
        gnomeExtensions.dash-to-panel
        google-chrome
        kitty
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
      pkgs.kdePackages.xdg-desktop-portal-kde
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

  programs.zoom-us.enable = true;
}

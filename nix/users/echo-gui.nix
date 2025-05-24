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
    "text/html" = "chooser.sh.desktop";
    "x-scheme-handler/http" = "chooser.sh.desktop";
    "x-scheme-handler/https" = "chooser.sh.desktop";
    "x-scheme-handler/about" = "chooser.sh.desktop";
    "x-scheme-handler/unknown" = "chooser.sh.desktop";
  };
}

{
  pkgs,
  inputs,
  ...
}: {
  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgs.system}.default;
  };

  systemd.user.services.onepassword = {
    Unit = {
      Description = "1Password";
      After = ["graphical-session.target"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs._1password-gui}/bin/1password --silent";
      Restart = "on-failure";
      RestartSec = "5";
    };

    Install = {
      WantedBy = ["default.target"];
    };
  };

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
    iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = pkgs.gruvbox-plus-icons;
    };
    cursorTheme = {
      name = "Capitaine Cursors (Gruvbox)";
      package = pkgs.capitaine-cursors-themed;
    };
  };

  home.sessionVariables.GTK_THEME = "Gruvbox-Dark";

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  # home.file.".config/xdg-settings/default-web-browser".text = "zen.desktop";

  # Desktop environments and window managers
  #xdg.configFile."hypr" = {
  #source = ../../hypr/.config/hypr;
  #recursive = true;
  #};
  # xdg.configFile."i3" = {
  #   force = true;
  #   source = ../../i3/.config/i3;
  #   recursive = true;
  # };
  # xdg.configFile."awesome" = {
  #   force = true;
  #   source = ../../awesome/.config/awesome;
  #   recursive = true;
  # };
  # # Bars and panels
  # # xdg.configFile."waybar" = {
  # #   source = ../../waybar/.config/waybar;
  # #   recursive = true;
  # # };
  # xdg.configFile."polybar" = {
  #   force = true;
  #   source = ../../polybar/.config/polybar;
  #   recursive = true;
  # };
  # xdg.configFile."sketchybar" = {
  #   force = true;
  #   source = ../../sketchybar/.config/sketchybar;
  #   recursive = true;
  # };
  #
  # # Application launchers
  # xdg.configFile."rofi" = {
  #   force = true;
  #   source = ../../rofi/.config/rofi;
  #   recursive = true;
  # };
  # xdg.configFile."walker" = {
  #   force = true;
  #   source = ../../walker/.config/walker;
  #   recursive = true;
  # };
  #
  # # Notifications
  # xdg.configFile."dunst" = {
  #   force = true;
  #   source = ../../dunst/.config/dunst;
  #   recursive = true;
  # };
  #
  # # Screenshots
  # xdg.configFile."flameshot" = {
  #   force = true;
  #   source = ../../flameshot/.config/flameshot;
  #   recursive = true;
  # };
  #
  # # macOS specific
  # xdg.configFile."aerospace" = {
  #   force = true;
  #   source = ../../aerospace/.config/aerospace;
  #   recursive = true;
  # };
  #
  # # Web browsers
  # xdg.configFile."zen/chrome" = {
  #   force = true;
  #   source = ../../zen/.config/zen/chrome;
  #   recursive = true;
  # };
  #
  # xdg.configFile."zen/user.js" = {
  #   force = true;
  #   source = ../../zen/.config/zen/user.js;
  # };
  #
  # xdg.configFile."zen/containers.json" = {
  #   force = true;
  #   source = ../../zen/.config/zen/containers.json;
  # };
  #
  # xdg.configFile."zen/zen-keyboard-shortcuts.json" = {
  #   force = true;
  #   source = ../../zen/.config/zen/zen-keyboard-shortcuts.json;
  # };
  #
  # # Theme frameworks
  # xdg.configFile."omarchy" = {
  #   force = true;
  #   source = ../../omarchy/.config/omarchy;
  #   recursive = true;
  # };
  #
  # # Fonts
  # xdg.dataFile."fonts" = {
  #   force = true;
  #   source = ../../fonts/.local/share/fonts;
  #   recursive = true;
  # };
  #
  # # Wallpapers
  # xdg.dataFile."wallpapers" = {
  #   force = true;
  #   source = ../../wallpaper/.local/share/wallpapers;
  #   recursive = true;
  # };
  #
  # # Art (ASCII art)
  # xdg.configFile."art" = {
  #   force = true;
  #   source = ../../art/.config/art;
  #   recursive = true;
  # };
  #
  # # Logos
  # xdg.dataFile."logos" = {
  #   force = true;
  #   source = ../../logos/.local/share/logos;
  #   recursive = true;
  # };
  #
  # # X11 startup
  # home.file.".xinitrc".source = ../../startx/.xinitrc;
  # # # Vesktop
  # # xdg.configFile."vesktop" = {
  # #   source = ../../vesktop/.config/vesktop;
  # #   recursive = true;
  # # };
}

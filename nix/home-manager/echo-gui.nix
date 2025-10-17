{
  pkgs,
  config,
  ...
}: {
  fonts.fontconfig.enable = true;

  services.cliphist = {
    allowImages = true;
    enable = true;
  };

  services.hyprpaper.enable = true;
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
        }
      ];
    };
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

  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
  gtk = {
    enable = true;
    gtk2.extraConfig = "gtk-application-prefer-dark-theme = true";
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    name = "Vanilla-DMZ";
    size = 64;
    package = pkgs.vanilla-dmz;
  };

  home.file.".config/xdg-settings/default-web-browser".text = "firefox.desktop";

  # Desktop environments and window managers
  xdg.configFile."hypr" = {
    source = ../../hypr/.config/hypr;
    recursive = true;
  };
  xdg.configFile."i3" = {
    source = ../../i3/.config/i3;
    recursive = true;
  };
  xdg.configFile."awesome" = {
    source = ../../awesome/.config/awesome;
    recursive = true;
  };
  xdg.configFile."cosmic" = {
    source = ../../cosmic/.config/cosmic;
    recursive = true;
  };

  # Bars and panels
  xdg.configFile."waybar" = {
    source = ../../waybar/.config/waybar;
    recursive = true;
  };
  xdg.configFile."polybar" = {
    source = ../../polybar/.config/polybar;
    recursive = true;
  };
  xdg.configFile."sketchybar" = {
    source = ../../sketchybar/.config/sketchybar;
    recursive = true;
  };

  # Application launchers
  xdg.configFile."rofi" = {
    source = ../../rofi/.config/rofi;
    recursive = true;
  };
  xdg.configFile."wofi" = {
    source = ../../wofi/.config/wofi;
    recursive = true;
  };
  xdg.configFile."walker" = {
    source = ../../walker/.config/walker;
    recursive = true;
  };

  # Notifications
  xdg.configFile."dunst" = {
    source = ../../dunst/.config/dunst;
    recursive = true;
  };

  # Screenshots
  xdg.configFile."flameshot" = {
    source = ../../flameshot/.config/flameshot;
    recursive = true;
  };

  # macOS specific
  xdg.configFile."aerospace" = {
    source = ../../aerospace/.config/aerospace;
    recursive = true;
  };

  # VS Code
  xdg.configFile."Code/User" = {
    source = ../../vscode/.config/Code/User;
    recursive = true;
  };

  # Web browsers
  xdg.configFile."zen" = {
    source = ../../zen/.config/zen;
    recursive = true;
  };

  # Theme frameworks
  xdg.configFile."omarchy" = {
    source = ../../omarchy/.config/omarchy;
    recursive = true;
  };

  # Fonts
  xdg.dataFile."fonts" = {
    source = ../../fonts/.local/share/fonts;
    recursive = true;
  };

  # Wallpapers
  xdg.dataFile."wallpapers" = {
    source = ../../wallpaper/.local/share/wallpapers;
    recursive = true;
  };

  # Art (ASCII art)
  xdg.configFile."art" = {
    source = ../../art/.config/art;
    recursive = true;
  };

  # Logos
  xdg.dataFile."logos" = {
    source = ../../logos/.local/share/logos;
    recursive = true;
  };

  # X11 startup
  home.file.".xinitrc".source = ../../startx/.xinitrc;
  # Vesktop
  xdg.configFile."vesktop" = {
    source = ../../vesktop/.config/vesktop;
    recursive = true;
  };
}

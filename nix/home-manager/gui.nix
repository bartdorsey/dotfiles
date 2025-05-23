{
  pkgs,
  zen-browser,
  system,
  ...
}: {
  catppuccin.enable = true;
  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      nativeMessagingHosts = [
        pkgs.gnome-browser-connector
      ];
    };
  };

  home.packages = with zen-browser; [
    packages."${system}".default
  ];

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

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    name = "Vanilla-DMZ";
    size = 64;
    package = pkgs.vanilla-dmz;
  };
}

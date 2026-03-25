{pkgs, ...}: {
  # Enable the SDDM login Manager
  services.displayManager.sddm.enable = true;

  # Enable the KDE Plasma desktop environment
  services.desktopManager = {
    plasma6 = {
      enable = true;
      enableQt5Integration = true;
    };
  };

  qt.platformTheme = "kde";

  services.system76-scheduler.enable = true;

  environment.systemPackages = with pkgs; [
    quick-webapps
  ];

  programs.firefox.preferences = {
    # disable libadwaita theming for Firefox
    "widget.gtk.libadwaita-colors.enabled" = false;
  };
}

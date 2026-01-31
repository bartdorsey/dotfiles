{pkgs, ...}: {
  # Enable the COSMIC login manager
  services.displayManager.cosmic-greeter.enable = true;

  # Enable the COSMIC desktop environment
  services.desktopManager.cosmic.enable = true;

  services.system76-scheduler.enable = true;

  environment.systemPackages = with pkgs; [
    cosmic-ext-applet-external-monitor-brightness
    cosmic-ext-applet-caffeine
    cosmic-ext-applet-minimon
    cosmic-ext-applet-privacy-indicator
    cosmic-ext-calculator
    cosmic-ext-ctl
    cosmic-ext-tweaks
    quick-webapps
  ];

  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

  programs.firefox.preferences = {
    # disable libadwaita theming for Firefox
    "widget.gtk.libadwaita-colors.enabled" = false;
  };
}

{...}: {
  # Enable the COSMIC login manager
  services.displayManager.cosmic-greeter.enable = true;

  # Enable the COSMIC desktop environment
  services.desktopManager.cosmic.enable = true;

  services.system76-scheduler.enable = true;

  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

  programs.firefox.preferences = {
    # disable libadwaita theming for Firefox
    "widget.gtk.libadwaita-colors.enabled" = false;
  };
}

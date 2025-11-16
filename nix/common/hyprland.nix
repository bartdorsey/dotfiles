{
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}: {
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  environment.systemPackages = with pkgs; [
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    hyprpaper
    hyprshot
    hyprsunset
    hyprpolkitagent
    # inputs.wezterm.packages.${pkgs.system}.default
    mpv
    mako
    imv
    satty
    walker
  ];
}

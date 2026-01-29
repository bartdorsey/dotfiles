{
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}: {
  # Enable Display Manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet \
          --time --time-format '%I:%M %p | %a • %h | %F' \
          --cmd 'uwsm start hyprland'";
        user = "greeter";
      };
    };
  };

  users.users.greeter = {
    isNormalUser = false;
    description = "greetd greeter user";
    extraGroups = ["video" "audio"];
    linger = true;
  };

  environment.systemPackages = with pkgs; [
    tuigreet
  ];
  programs.firefox.preferences = {
    # disable libadwaita theming for Firefox
    "widget.gtk.libadwaita-colors.enabled" = false;
  };
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

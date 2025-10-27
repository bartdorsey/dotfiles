{
  pkgs,
  pkgs-unstable,
  ...
}: {
  # My user account, with gui specific packages
  users.users.echo = {
    extraGroups = ["networkmanager" "wheel" "docker" "audio"];
  };

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
      config.common.default = ["hyprland" "gtk"];
    };
    # Default applications
    terminal-exec = {
      enable = true;
      settings = {
        default = [
          "wezterm.desktop"
        ];
      };
    };

    mime.defaultApplications = {
      "inode/directory" = "yazi.desktop";
      "inode/mount-point" = "yazi.desktop";
    };
  };
}

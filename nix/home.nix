{
  config,
  pkgs,
  ...
}: {
  home.username = "echo";
  home.homeDirectory = "/home/echo";

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}

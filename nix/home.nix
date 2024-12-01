{
  config,
  pkgs,
  ...
}: {
  home.username = "echo";
  home.homeDirectory = "/home/echo";

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}

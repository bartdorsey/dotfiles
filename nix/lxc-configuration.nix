# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  pkgs,
  systemPackages,
  ...
}: let
in {
  imports = [];

  time.timeZone = "US/Central";

  networking.nameservers = ["10.0.0.3" "10.0.0.4"];
  networking.domain = "home";

  users.users.echo = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Bart Dorsey";
    extraGroups = ["networkmanager" "wheel" "docker"];
  };

  users.groups.echo = {
    name = "echo";
    members = ["echo"];
    gid = 1000;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "nix-2.16.2"
  ];

  environment.systemPackages = systemPackages;

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  # vscode-remote-workaround.enable = true;

  # programs.nh = {
  #   enable = true;
  #   clean.enable = true;
  #   clean.extraArgs = "--keep-since 4d --keep 3";
  #   flake = "/home/echo/.dotfiles/";
  # };

  programs.zsh = {
    enable = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      port = 2222;
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  virtualisation.docker.enable = true;

  documentation.man.generateCaches = true;

  system.stateVersion = "24.11"; # Did you read the comment?
}

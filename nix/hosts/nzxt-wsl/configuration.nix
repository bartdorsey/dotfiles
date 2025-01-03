# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{pkgs, ...}: {
  imports = [];

  wsl.enable = true;
  wsl.defaultUser = "echo";
  wsl.wslConf.interop.appendWindowsPath = false;
  wsl.wslConf.network.hostname = "nzxt-wsl";
  wsl.wslConf.network.generateResolvConf = false;
  wsl.useWindowsDriver = true;
  wsl.startMenuLaunchers = true;
  time.timeZone = "US/Central";

  networking.nameservers = ["10.0.0.3" "10.0.0.4"];
  networking.domain = "home";

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/2d7c255f-2e84-4127-9205-12c2086b8a34";
    fsType = "btrfs";
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "nix-2.16.2"
  ];

  environment.systemPackages = with pkgs; [
    wsl-open
    wslu
  ];

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  services.openssh = {
    enable = true;
    settings = {
      port = 2222;
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  virtualisation.docker.enable = true;

  documentation.man.generateCaches = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

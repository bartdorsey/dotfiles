# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{modulesPath, ...}: let
in {
  imports = [(modulesPath + "/virtualisation/proxmox-lxc.nix")];
  nix.settings = {sandbox = false;};
  systemd.mounts = [
    {
      where = "/sys/kernel/debug";
      enable = false;
    }
  ];
  proxmoxLXC = {
    manageNetwork = false;
    privileged = true;
  };

  networking.nameservers = ["10.0.0.3" "10.0.0.4"];

  networking.firewall.enable = false;
  nixpkgs.config.permittedInsecurePackages = [
    "nix-2.16.2"
  ];

  # services.ollama = {
  #   enable = true;
  #   # Optional: load models on startup
  #   loadModels = [];
  # };
  # services.open-webui = {
  #   enable = true;
  #   host = "0.0.0.0";
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  system.stateVersion = "24.11"; # Did you read the comment?
}

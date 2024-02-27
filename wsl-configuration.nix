# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
  ];

  wsl.enable = true;
  wsl.defaultUser = "echo";

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/2d7c255f-2e84-4127-9205-12c2086b8a34";
      fsType = "btrfs";
    };
 
  users.users.echo = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Bart Dorsey";
    extraGroups = ["networkmanager"  "wheel"];
    packages = with pkgs; [
       vim
       neovim
       git
       nodejs_20
       (python310.withPackages (ps: with ps; [pip]))
       starship
       lazygit
       pass
       ripgrep
       fzf
       stow
       zoxide
       nixd
       fd
    ];
  }; 

  users.groups.echo = {
    name = "echo";
    members = ["echo"];
    gid = 1000;
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    zsh
    neovim
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };  


  programs.zsh = {
    enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

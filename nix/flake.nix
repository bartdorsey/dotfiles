{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixoswsl.url = "github:nix-community/NixOS-WSL";
    nixoswsl.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    nixoswsl,
    nixpkgs-unstable,
    home-manager,
    ...
  }: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";

    pkgs-unstable = import nixpkgs-unstable {
      config.allowUnfree = true;
      inherit system;
    };

    pkgs = import nixpkgs {
      config.allowUnfree = true;
      inherit system;
    };

    systemPackages = with pkgs; [
      wget
      zsh
      usbutils
      killall
      dig
      vim
      htop
      btop
      fastfetch
      stdenv.cc.cc
      inetutils
      tmux
      file
      kmod
      iotop
      iotop-c
      iperf3
      zip
      unzip
      sysz
      gnumake
      gita
      uv
      gcc
      glibc
      binutils
    ];
  in {
    nixosConfigurations = {
      nzxt = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit pkgs;
          inherit pkgs-unstable;
          inherit systemPackages;
        };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.echo = import ./home.nix;
          }
        ];
      };
      nzxt-wsl = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit pkgs;
          inherit pkgs-unstable;
          inherit systemPackages;
        };
        modules = [
          nixoswsl.nixosModules.wsl
          ./wsl-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.echo = import ./home.nix;
          }
        ];
      };
    };
  };
}

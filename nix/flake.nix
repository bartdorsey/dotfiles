{
  description = "NixOS Configs";

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
  in {
    nixosConfigurations = {
      nzxt = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit pkgs-unstable;
        };
        modules = [
          ./hosts/nzxt/configuration.nix
          ./common/system-packages.nix
          ./user.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit pkgs-unstable;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.echo = import ./home.nix;
          }
        ];
      };
      nzxt-wsl = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit pkgs-unstable;
        };
        modules = [
          nixoswsl.nixosModules.wsl
          ./hosts/nzxt-wsl/configuration.nix
          ./common/system-packages.nix
          ./user.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit pkgs-unstable;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.echo = import ./home.nix;
          }
        ];
      };
      nixos-dev = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit pkgs-unstable;
        };
        modules = [
          ./hosts/nixos-dev/configuration.nix
          ./common/system-packages.nix
          ./user.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit pkgs-unstable;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.echo = import ./home.nix;
          }
        ];
      };
    };
  };
}

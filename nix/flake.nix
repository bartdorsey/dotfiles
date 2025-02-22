{
  description = "NixOS Configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixoswsl.url = "github:nix-community/NixOS-WSL";
    nixoswsl.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = {
    nixpkgs,
    nixoswsl,
    nixpkgs-unstable,
    home-manager,
    catppuccin,
    zen-browser,
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
      nixos-vm = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit pkgs-unstable;
        };
        modules = [
          ./hosts/nixos-vm/configuration.nix
          ./common/os.nix
          ./common/system-packages.nix
          ./common/gui.nix
          ./users/echo.nix
          ./users/echo-gui.nix
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit pkgs-unstable;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.echo = {
              imports = [
                ./home-manager/home.nix
                ./home-manager/gui.nix
                catppuccin.homeManagerModules.catppuccin
              ];
            };
          }
        ];
      };
      nzxt = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit pkgs-unstable;
        };
        modules = [
          ./hosts/nzxt/configuration.nix
          ./common/os.nix
          ./common/gui.nix
          ./common/system-packages.nix
          ./users/echo.nix
          ./users/echo-gui.nix
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit pkgs-unstable;
              inherit zen-browser;
              inherit system;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.echo = {
              imports = [
                ./home-manager/home.nix
                ./home-manager/gui.nix
                catppuccin.homeManagerModules.catppuccin
              ];
            };
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
          ./common/os.nix
          ./common/nfs.nix
          ./hosts/nzxt-wsl/configuration.nix
          ./common/system-packages.nix
          ./users/echo.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit pkgs-unstable;
            };

            nixpkgs.config.allowUnfree = true;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.echo = {
              imports = [
                ./home-manager/home.nix
              ];
            };
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
          ./common/os.nix
          ./common/system-packages.nix
          ./users/echo.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit pkgs-unstable;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.echo = {
              imports = [
                ./home-manager/home.nix
              ];
            };
          }
        ];
      };
    };
  };
}

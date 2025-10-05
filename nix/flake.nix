{
  description = "NixOS Configs";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixoswsl.url = "github:nix-community/nixos-wsl/release-25.05";
    nixoswsl.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wezterm.url = "github:wez/wezterm?dir=nix";
  };

  outputs = {
    nixpkgs,
    nixoswsl,
    nixpkgs-unstable,
    home-manager,
    zen-browser,
    nixos-hardware,
    ...
  } @ inputs: let
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
          inherit zen-browser;
          inherit system;
          inherit inputs;
        };
        modules = [
          ./hosts/nzxt/configuration.nix
          ./hosts/nzxt/hardware-configuration.nix
          ./hosts/nzxt/nvidia.nix
          nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
          ./common/os.nix
          ./common/mounts.nix
          ./common/gui.nix
          ./common/display-manager.nix
          ./common/hyprland.nix
          ./common/system-packages.nix
          ./users/echo.nix
          ./users/echo-gui.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit pkgs-unstable;
              inherit system;
            };
            nixpkgs.config.allowUnfree = true;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.echo = {
              imports = [
                ./home-manager/echo.nix
                ./home-manager/echo-gui.nix
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
          ./common/mounts.nix
          ./hosts/nzxt-wsl/configuration.nix
          ./common/system-packages.nix
          ./users/echo.nix
          ./users/guest.nix
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
                ./home-manager/echo.nix
              ];
            };
            home-manager.users.guest = {
              imports = [
                ./home-manager/guest.nix
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
            nixpkgs.config.allowUnfree = true;
            home-manager.extraSpecialArgs = {
              inherit pkgs-unstable;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.echo = {
              imports = [
                ./home-manager/echo.nix
              ];
            };
          }
        ];
      };
    };
  };
}

{
  description = "NixOS Configs";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.11";
    };
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixoswsl = {
      url = "github:nix-community/nixos-wsl/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cli = {
      url = "github:nix-community/nixos-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wezterm.url = "github:wez/wezterm?dir=nix";
    wasabi375 = {
      url = "github:Wasabi375/nix-wasabipkgs/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cos-cli = {
      url = "github:estin/cos-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    nixoswsl,
    nixpkgs-unstable,
    home-manager,
    nixos-cli,
    nixos-hardware,
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
          inherit inputs;
        };
        modules = [
          ./hosts/nzxt/bootloader.nix
          ./hosts/nzxt/configuration.nix
          ./hosts/nzxt/hardware-configuration.nix
          ./hosts/nzxt/nvidia.nix
          ./common/theme.nix
          ./common/os.nix
          ./common/tailscale.nix
          ./common/mounts.nix
          ./common/gui.nix
          ./common/cosmic.nix
          ./common/obs-studio.nix
          ./common/vscode.nix
          ./common/steam.nix
          # ./common/plasma.nix
          ./common/system-packages.nix
          ./common/virtual-machines.nix
          ./common/incus.nix
          ./users/echo.nix
          ./users/echo-gui.nix
          home-manager.nixosModules.home-manager
          nixos-cli.nixosModules.nixos-cli
          {
            nixpkgs.config.allowUnfree = true;
            home-manager = {
              extraSpecialArgs = {inherit pkgs-unstable inputs;};
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.echo = {
                imports = [
                  ./home-manager/echo.nix
                  ./home-manager/echo-gui.nix
                ];
              };
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
          ./hosts/nzxt-wsl/configuration.nix
          ./common/os.nix
          ./common/tailscale.nix
          ./common/mounts.nix
          ./common/system-packages.nix
          ./users/echo.nix
          home-manager.nixosModules.home-manager
          nixos-cli.nixosModules.nixos-cli
          {
            nixpkgs.config.allowUnfree = true;
            home-manager = {
              extraSpecialArgs = {inherit pkgs-unstable;};
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.echo = import ./home-manager/echo.nix;
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
          ./common/tailscale.nix
          ./common/system-packages.nix
          ./users/echo.nix
          home-manager.nixosModules.home-manager
          nixos-cli.nixosModules.nixos-cli
          {
            nixpkgs.config.allowUnfree = true;
            home-manager = {
              extraSpecialArgs = {inherit pkgs-unstable;};
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.echo = import ./home-manager/echo.nix;
            };
          }
        ];
      };
    };
  };
}

{
  
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixoswsl.url = "github:nix-community/NixOS-WSL";
    nixoswsl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixoswsl, nixpkgs-unstable, ... }: 
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
      };
    in {
    nixosConfigurations = {
      nzxt = lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ];
      };
      nzxt-wsl = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgs-unstable; inherit pkgs; };
        modules = [ nixoswsl.nixosModules.wsl ./wsl-configuration.nix ];
      };
    };
  };
  
}

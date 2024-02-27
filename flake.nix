{
  
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixoswsl.url = "github:nix-community/NixOS-WSL";
    nixoswsl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixoswsl, ... }: 
    let 
      lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      nzxt = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
      };
      nzxt-wsl = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ nixoswsl.nixosModules.wsl ./wsl-configuration.nix ];
      };
    };
  };
  
}

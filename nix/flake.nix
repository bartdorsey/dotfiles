{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixoswsl.url = "github:nix-community/NixOS-WSL";
    nixoswsl.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
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

    stableSystemPackages = with pkgs; [
      vim
      wget
      zsh
    ];

    unstableUserPackages = with pkgs-unstable; [
      dust
      nh
      nix-output-monitor
      nvd
      neovim
      opam
      yazi
    ];

    stableUserPackages = with pkgs; [
      vim
      (python312.withPackages (ps: with ps; [pip flake8 black pipx ipython bpython vdirsyncer]))
      git
      git-lfs
      nodejs_22
      starship
      lazygit
      pass
      ripgrep
      fzf
      stow
      zoxide
      nixd
      fd
      fastfetch
      htop
      btop
      lsd
      grc
      corepack_20
      rustup
      stdenv.cc.cc
      pyright
      ruff
      ruff-lsp
      tmux
      gh
      clang
      alejandra
      lazydocker
      khal
      sesh
      gum
      bun
      deno
      go
      swift
      sqlite
      inetutils
      mc
      helix
    ];

    userPackages = unstableUserPackages ++ stableUserPackages;
    systemPackages = stableSystemPackages;
  in {
    nixosConfigurations = {
      nzxt = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit pkgs;
          inherit pkgs-unstable;
          inherit userPackages;
          inherit systemPackages;
        };
        modules = [./configuration.nix];
      };
      nzxt-wsl = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit pkgs;
          inherit pkgs-unstable;
          inherit userPackages;
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

{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixoswsl.url = "github:nix-community/NixOS-WSL";
    nixoswsl.inputs.nixpkgs.follows = "nixpkgs";
    nixoswsl.inputs.flake-utils.follows = "flake-utils";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    git-repo-manager = {
      url = "github:hakoerber/git-repo-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = {
    nixpkgs,
    nixoswsl,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";

    pkgs-unstable = import nixpkgs-unstable {
      config.allowUnfree = true;
      inherit system;
    };

    pkgs = import nixpkgs {
      config.allowUnfree = true;
      inherit system;
      overlays = [inputs.git-repo-manager.overlays.git-repo-manager];
    };

    stableSystemPackages = with pkgs; [
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
      git-repo-manager
    ];

    unstableSystemPackages = with pkgs-unstable; [
    ];

    unstableUserPackages = with pkgs-unstable; [
    ];

    stableUserPackages = with pkgs; [
      (python312.withPackages (ps: with ps; [pip flake8 black pipx ipython bpython vdirsyncer]))
      neovim
      dust
      nh
      nix-output-monitor
      nvd
      opam
      yazi
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
      lsd
      grc
      rustup
      pyright
      ruff
      ruff-lsp
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
      mc
      helix
      prettierd
      glab
      cloc
      mise
      gcc
      glibc
      binutils
      lua
      luarocks
      tree
      hub
      xdg-utils
      tree-sitter
      vdirsyncer
      image_optim
    ];

    userPackages = unstableUserPackages ++ stableUserPackages;
    systemPackages = unstableSystemPackages ++ stableSystemPackages;
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

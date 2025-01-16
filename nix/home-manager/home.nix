{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.username = "echo";
  home.homeDirectory = "/home/echo";

  home.packages =
    (with pkgs; [
      (python312.withPackages (ps: with ps; [pip flake8 black pipx ipython bpython vdirsyncer]))
      alejandra
      bun
      clang
      cloc
      deno
      dust
      fd
      fzf
      git
      git-lfs
      gh
      glab
      go
      gnupg
      grc
      gum
      helix
      hub
      image_optim
      khal
      lazydocker
      lazygit
      lsd
      lua
      luarocks
      mc
      mise
      neovim
      nh
      nix-output-monitor
      nixd
      nodejs_22
      nvd
      opam
      p7zip
      pass
      pinentry
      prettierd
      pyright
      ripgrep
      ruff
      ruff-lsp
      rustup
      sesh
      sqlite
      starship
      stow
      tree
      tree-sitter
      unzip
      xdg-utils
      yazi
      zip
      zoxide
    ])
    ++ (with pkgs-unstable; [
      uv
    ]);

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}

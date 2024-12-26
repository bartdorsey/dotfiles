{
  config,
  pkgs,
  ...
}: let
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
    sqlite
    mc
    helix
    prettierd
    glab
    cloc
    mise
    lua
    luarocks
    tree
    hub
    xdg-utils
    tree-sitter
    image_optim
    unzip
    zip
    p7zip
  ];

  userPackages = stableUserPackages;
in {
  home.username = "echo";
  home.homeDirectory = "/home/echo";
  home.packages = userPackages;
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };
}

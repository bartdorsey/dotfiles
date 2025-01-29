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
      bat
      buku
      bun
      clang
      cloc
      deno
      devbox
      dust
      fd
      fzf
      git
      git-lfs
      gh
      glab
      go
      gopls
      gotools
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
      mosh
      mtr
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
      sqlite
      starship
      stow
      syncthing
      tree
      tree-sitter
      unzip
      xdg-utils
      yazi
      yarn
      zip
      zoxide
    ])
    ++ (with pkgs-unstable; [
      uv
    ]);

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  programs.go = {
    enable = true;
  };
  services.syncthing = {
    enable = true;
  };

  # programs.git = {
  #   enable = true;
  #   userName = "Bart Dorsey";
  #   userEmail = "bart@bartdorsey.com";
  #   aliases = {
  #     co = "checkout";
  #     st = "status";
  #     ci = "commit";
  #     br = "branch";
  #   };
  #   extraConfig = {
  #     core = {
  #       editor = "nvim";
  #     };
  #     color = {
  #       ui = "auto";
  #       branch = "auto";
  #       diff = "auto";
  #       interactive = "auto";
  #       status = "auto";
  #     };
  #     push = {
  #       default = "simple";
  #     };
  #     pull = {
  #       rebase = true;
  #     };
  #     init = {
  #       defaultBranch = "main";
  #     };
  #   };
  #   ignores = [
  #     "__pycache__/"
  #     ".pytest_cache/"
  #     ".DS_Store"
  #     ".nvim"
  #     ".mypy_cache/"
  #     ".venv/"
  #   ];
  #   delta = {
  #     enable = true;
  #     options = {
  #       navigate = true;
  #       line-numbers = true;
  #     };
  #   };
  # };
  # xdg.configFile."nvim" = {
  #   source = ../../nvim/.config/nvim;
  #   recursive = true;
  # };
}

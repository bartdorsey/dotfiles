{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.username = "guest";
  home.homeDirectory = "/home/guest";

  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages =
    (with pkgs; [
      (python3.withPackages (ps:
        with ps; [
          pip
          flake8
          black
          pipx
          ipython
          bpython
          pgcli
          mypy
          vdirsyncer
        ]))
      alejandra
      bat
      buku
      bun
      clang
      cloc
      curl
      curlie
      deno
      devbox
      distrobox
      distrobox-tui
      dust
      dune_3
      emacs-nox
      fd
      fzf
      git
      git-lfs
      gh
      glab
      gleam
      glow
      go
      gopls
      gotools
      gnupg
      grc
      gum
      helix
      hub
      image_optim
      intelephense
      jq
      khal
      lazydocker
      lazygit
      lsd
      lua
      luarocks
      mc
      micro
      mise
      mosh
      mtr
      nh
      nix-output-monitor
      nixd
      nvd
      ocaml
      ocamlformat
      ocamlPackages.findlib
      ocamlPackages.ocaml-lsp
      optinix
      p7zip
      pass
      php
      pinentry
      pnpm
      postgresql
      prettierd
      pyright
      ripgrep
      ruff
      rustup
      sqlite
      starship
      stow
      superfile
      syncthing
      tree
      tree-sitter
      unzip
      uv
      vtm
      xdg-utils
      xh
      wezterm
      wget
      yazi
      yarn
      yt-dlp
      zip
      zoxide
    ])
    ++ (with pkgs-unstable; [
      nodejs
    ]);

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  programs.go = {
    enable = true;
  };
  services.syncthing = {
    enable = true;
  };

  programs.git = {
    enable = true;
    aliases = {
      co = "checkout";
      st = "status";
      ci = "commit";
      br = "branch";
    };
    extraConfig = {
      core = {
        editor = "nvim";
      };
      color = {
        ui = "auto";
        branch = "auto";
        diff = "auto";
        interactive = "auto";
        status = "auto";
      };
      push = {
        default = "simple";
      };
      pull = {
        rebase = true;
      };
      init = {
        defaultBranch = "main";
      };
    };
    ignores = [
      "__pycache__/"
      ".pytest_cache/"
      ".DS_Store"
      ".nvim"
      ".mypy_cache/"
      ".venv/"
    ];
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
      };
    };
    lfs.enable = true;
  };
  # xdg.configFile."nvim" = {
  #   source = ../../nvim/.config/nvim;
  #   recursive = true;
  # };
}

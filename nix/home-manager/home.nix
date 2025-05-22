{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.username = "echo";
  home.homeDirectory = "/home/echo";

  home.packages =
    (with pkgs; [
      (python312.withPackages (ps:
        with ps; [
          pip
          flake8
          black
          pipx
          ipython
          bpython
          pgcli
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
      diff-so-fancy
      distrobox
      distrobox-tui
      dust
      dune_3
      emacs-nox
      evil-helix
      fd
      fselect
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
      mprocs
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
      ruff-lsp
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
      television
    ]);

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  programs.go = {
    enable = true;
  };
  services.syncthing = {
    enable = true;
  };

  services.git-sync = {
    enable = true;
    repositories = {
      Obsidian = {
        path = /home/echo/Obsidian/Journal;
        uri = "git@github.com:bartdorsey/obsidian.git";
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "Bart Dorsey";
    userEmail = "bart@bartdorsey.com";
    aliases = {
      co = "checkout";
      st = "status --short";
      ci = "commit";
      br = "branch";
      ap = "add --patch";
      lg = "log --oneline --graph --all";
    };
    extraConfig = {
      core = {
        editor = "nvim";
      };
      commit = {
        verbose = true;
      };
      color = {
        ui = "auto";
        branch = "auto";
        diff = "auto";
        interactive = "auto";
        status = "auto";
      };
      diff = {
        context = 3;
        rename = "copies";
        interHunkContext = 10;
      };
      interactive = {
        diffFilter = "diff-so-fancy --patch";
        singleKey = true;
      };
      pager = {
        diff = "diff-so-fancy | $PAGER";
      };
      diff-so-fancy = {
        markEmptyLines = false;
      };
      push = {
        autoSetupRemote = true;
        default = "current";
        followTags = true;
      };
      pull = {
        default = "current";
        rebase = true;
      };
      rebase = {
        autoStash = true;
        missingCommitsCheck = "warn";
      };
      init = {
        defaultBranch = "main";
      };
      status = {
        branch = true;
        showStash = true;
        showUntrackedFiles = true;
      };
      log = {
        decorate = "short";
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
    lfs.enable = true;
  };
  # xdg.configFile."nvim" = {
  #   source = ../../nvim/.config/nvim;
  #   recursive = true;
  # };
}

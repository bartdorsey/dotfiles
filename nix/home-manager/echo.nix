{
  pkgs,
  config,
  ...
}: {
  home.username = "echo";
  home.homeDirectory = "/home/echo";

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  programs.go = {
    enable = true;
  };
  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8385";
  };

  # services.git-sync = {
  #   enable = true;
  #   repositories = {
  #     Obsidian = {
  #       path = /home/echo/Obsidian;
  #       uri = "git@github.com:bartdorsey/obsidian.git";
  #     };
  #   };
  # };

  # programs.zsh = {
  #   enable = true;
  #   enableCompletion = true;
  #   dotDir = config.xdg.configHome + "/nix-zsh";
  #   plugins = [
  #     {
  #       name = "zsh-nix-shell";
  #       file = "nix-shell.plugin.zsh";
  #       src = pkgs.fetchFromGitHub {
  #         owner = "chisui";
  #         repo = "zsh-nix-shell";
  #         rev = "v0.8.0";
  #         sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
  #       };
  #     }
  #   ];
  # };

  # programs.git = {
  #   enable = true;
  #   settings = {
  #     user = {
  #       name = "Bart Dorsey";
  #       email = "bart@bartdorsey.com";
  #     };
  #     aliases = {
  #       co = "checkout";
  #       st = "status";
  #       ci = "commit";
  #       br = "branch";
  #     };
  #     extraConfig = {
  #       core = {
  #         editor = "nvim";
  #       };
  #       color = {
  #         ui = "auto";
  #         branch = "auto";
  #         diff = "auto";
  #         interactive = "auto";
  #         status = "auto";
  #       };
  #       push = {
  #         default = "simple";
  #         followTags = true;
  #       };
  #       pull = {
  #         rebase = true;
  #       };
  #       init = {
  #         defaultBranch = "main";
  #       };
  #     };
  #   };
  #   ignores = [
  #     "__pycache__/"
  #     ".pytest_cache/"
  #     ".DS_Store"
  #     ".nvim"
  #     ".mypy_cache/"
  #     ".venv/"
  #     "**/.claude/settings.local.json"
  #   ];
  #   lfs.enable = true;
  # };
  # programs.delta = {
  #   enable = true;
  #   enableGitIntegration = true;
  #   options = {
  #     navigate = true;
  #     line-numbers = true;
  #   };
  # };
  # # --- dotfiles ---
  # # Core configs
  # xdg.configFile."nvim" = {
  #   force = true;
  #   source = ../../nvim/.config/nvim;
  #   recursive = true;
  # };
  # xdg.configFile."vim" = {
  #   force = true;
  #   source = ../../vim/.config/vim;
  #   recursive = true;
  # };
  # xdg.configFile."common" = {
  #   force = true;
  #   source = ../../common/.config/common;
  #   recursive = true;
  # };
  # xdg.configFile."zsh" = {
  #   force = true;
  #   source = ../../zsh/.config/zsh;
  #   recursive = true;
  # };
  # home.file.".zshenv".source = ../../zsh/.zshenv;
  # home.file.".bash_profile".source = ../../bash/.bash_profile;
  # xdg.configFile."bash" = {
  #   force = true;
  #   source = ../../bash/.config/bash;
  #   recursive = true;
  # };
  #
  # # Terminal emulators
  # xdg.configFile."alacritty" = {
  #   force = true;
  #   source = ../../alacritty/.config/alacritty;
  #   recursive = true;
  # };
  # xdg.configFile."kitty" = {
  #   force = true;
  #   source = ../../kitty/.config/kitty;
  #   recursive = true;
  # };
  # xdg.configFile."wezterm" = {
  #   force = true;
  #   source = ../../wezterm/.config/wezterm;
  #   recursive = true;
  # };
  #
  # # Terminal multiplexer and shell prompt
  # xdg.configFile."tmux" = {
  #   force = true;
  #   source = ../../tmux/.config/tmux;
  #   recursive = true;
  # };
  # xdg.configFile."starship.toml".source = ../../starship/.config/starship.toml;
  # xdg.configFile."zellij" = {
  #   force = true;
  #   source = ../../zellij/.config/zellij;
  #   recursive = true;
  # };
  #
  # # Development tools
  # xdg.configFile."bat" = {
  #   force = true;
  #   source = ../../bat/.config/bat;
  #   recursive = true;
  # };
  # xdg.configFile."direnv" = {
  #   force = true;
  #   source = ../../direnv/.config/direnv;
  #   recursive = true;
  # };
  # xdg.configFile."lazygit" = {
  #   force = true;
  #   source = ../../lazygit/.config/lazygit;
  #   recursive = true;
  # };
  # xdg.configFile."helix" = {
  #   force = true;
  #   source = ../../helix/.config/helix;
  #   recursive = true;
  # };
  #
  # # File managers and viewers
  # xdg.configFile."lf" = {
  #   force = true;
  #   source = ../../lf/.config/lf;
  #   recursive = true;
  # };
  # xdg.configFile."superfile" = {
  #   force = true;
  #   source = ../../superfile/.config/superfile;
  #   recursive = true;
  # };
  # xdg.configFile."sesh" = {
  #   force = true;
  #   source = ../../sesh/.config/sesh;
  #   recursive = true;
  # };
  #
  # # System monitors
  # xdg.configFile."btop" = {
  #   force = true;
  #   source = ../../btop/.config/btop;
  #   recursive = true;
  # };
  # xdg.configFile."htop" = {
  #   force = true;
  #   source = ../../htop/.config/htop;
  #   recursive = true;
  # };
  #
  # # System info and fetch tools
  # xdg.configFile."fastfetch" = {
  #   force = true;
  #   source = ../../fastfetch/.config/fastfetch;
  #   recursive = true;
  # };
  # xdg.configFile."macchina" = {
  #   force = true;
  #   source = ../../macchina/.config/macchina;
  #   recursive = true;
  # };
  #
  # # Mail and calendar
  # xdg.configFile."aerc" = {
  #   force = true;
  #   source = ../../aerc/.config/aerc;
  #   recursive = true;
  # };
  # xdg.configFile."khal" = {
  #   force = true;
  #   source = ../../khal/.config/khal;
  #   recursive = true;
  # };
  # xdg.configFile."vdirsyncer" = {
  #   force = true;
  #   source = ../../vdirsyncer/.config/vdirsyncer;
  #   recursive = true;
  # };
  #
  # # Media
  # xdg.configFile."rmpc" = {
  #   force = true;
  #   source = ../../rmpc/.config/rmpc;
  #   recursive = true;
  # };
  #
  # # Other utilities
  # xdg.configFile."lsd" = {
  #   force = true;
  #   source = ../../lsd/.config/lsd;
  #   recursive = true;
  # };
  # xdg.configFile."oh-my-posh" = {
  #   force = true;
  #   source = ../../oh-my-posh/.config/oh-my-posh;
  #   recursive = true;
  # };
  # xdg.configFile."prettierrc.json".source = ../../prettierd/.config/prettierrc.json;
  # xdg.configFile."wiki-tui" = {
  #   force = true;
  #   source = ../../wiki-tui/.config/wiki-tui;
  #   recursive = true;
  # };
  #
  # # Binaries and scripts
  # home.file.".local/scripts" = {
  #   force = true;
  #   source = ../../binaries/.local/scripts;
  #   recursive = true;
  # };
  #
  # # Zsh plugins (git-tracked ones)
  # xdg.dataFile."zsh/plugins/zsh-better-vi" = {
  #   force = true;
  #   source = ../../zsh/.local/share/zsh/plugins/zsh-better-vi;
  #   recursive = true;
  # };
  # xdg.dataFile."zsh/plugins/zsh-fzf" = {
  #   force = true;
  #   source = ../../zsh/.local/share/zsh/plugins/zsh-fzf;
  #   recursive = true;
  # };
  #
  # # Zsh plugins (from nixpkgs)
  # # Note: These are managed by home-manager using nixpkgs packages
  # xdg.dataFile."zsh/plugins/zsh-autosuggestions".source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
  # xdg.dataFile."zsh/plugins/fast-syntax-highlighting".source = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting";
  # xdg.dataFile."zsh/plugins/zsh-completions".source = "${pkgs.zsh-completions}/share/zsh/site-functions";
  # xdg.dataFile."zsh/plugins/fzf-tab".source = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
  # xdg.dataFile."zsh/plugins/zsh-autocomplete".source = "${pkgs.zsh-autocomplete}/share/zsh-autocomplete";
  #
  # # Terminfo
  # xdg.configFile."terminfo" = {
  #   force = true;
  #   source = ../../terminfo/.config/terminfo;
  #   recursive = true;
  # };
  #
  # # GnuPG
  # xdg.dataFile."gnupg" = {
  #   force = true;
  #   source = ../../gnupg/.local/share/gnupg;
  #   recursive = true;
  # };
  #
  # # Doom Emacs
  # home.file.".doom.d" = {
  #   force = true;
  #   source = ../../doom/.doom.d;
  #   recursive = true;
  # };
  #
  # # Claude CLI
  # home.file.".claude" = {
  #   force = true;
  #   source = ../../claude/.claude;
  #   recursive = true;
  # };
  # xdg.configFile."yazi" = {
  #   force = true;
  #   source = ../../yazi/.config/yazi;
  #   recursive = true;
  # };
}

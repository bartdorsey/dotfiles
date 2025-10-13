{...}: {
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

  programs.git = {
    enable = true;
    userName = "Bart Dorsey";
    userEmail = "bart@bartdorsey.com";
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
        followTags = true;
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
      "**/.claude/settings.local.json"
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
  # --- dotfiles ---
  # Core configs
  xdg.configFile."nvim" = {
    source = ../../nvim/.config/nvim;
    recursive = true;
  };
  xdg.configFile."vim" = {
    source = ../../vim/.config/vim;
    recursive = true;
  };
  xdg.configFile."common" = {
    source = ../../common/.config/common;
    recursive = true;
  };
  xdg.configFile."zsh" = {
    source = ../../zsh/.config/zsh;
    recursive = true;
  };
  home.file.".zshenv".source = ../../zshenv/.zshenv;
  home.file.".ssh" = {
    source = ../../ssh/.ssh;
    recursive = true;
  };
  home.file.".bash_profile".source = ../../bash/.bash_profile;
  xdg.configFile."bash" = {
    source = ../../bash/.config/bash;
    recursive = true;
  };

  # Terminal emulators
  xdg.configFile."alacritty" = {
    source = ../../alacritty/.config/alacritty;
    recursive = true;
  };
  xdg.configFile."kitty" = {
    source = ../../kitty/.config/kitty;
    recursive = true;
  };
  xdg.configFile."wezterm" = {
    source = ../../wezterm/.config/wezterm;
    recursive = true;
  };

  # Terminal multiplexer and shell prompt
  xdg.configFile."tmux" = {
    source = ../../tmux/.config/tmux;
    recursive = true;
  };
  xdg.configFile."starship.toml".source = ../../starship/.config/starship.toml;
  xdg.configFile."zellij" = {
    source = ../../zellij/.config/zellij;
    recursive = true;
  };

  # Development tools
  xdg.configFile."bat" = {
    source = ../../bat/.config/bat;
    recursive = true;
  };
  xdg.configFile."direnv" = {
    source = ../../direnv/.config/direnv;
    recursive = true;
  };
  xdg.configFile."mise" = {
    source = ../../mise/.config/mise;
    recursive = true;
  };
  xdg.configFile."lazygit" = {
    source = ../../lazygit/.config/lazygit;
    recursive = true;
  };
  xdg.configFile."helix" = {
    source = ../../helix/.config/helix;
    recursive = true;
  };

  # File managers and viewers
  xdg.configFile."lf" = {
    source = ../../lf/.config/lf;
    recursive = true;
  };
  xdg.configFile."superfile" = {
    source = ../../superfile/.config/superfile;
    recursive = true;
  };
  xdg.configFile."sesh" = {
    source = ../../sesh/.config/sesh;
    recursive = true;
  };

  # System monitors
  xdg.configFile."btop" = {
    source = ../../btop/.config/btop;
    recursive = true;
  };
  xdg.configFile."htop" = {
    source = ../../htop/.config/htop;
    recursive = true;
  };

  # System info and fetch tools
  xdg.configFile."fastfetch" = {
    source = ../../fastfetch/.config/fastfetch;
    recursive = true;
  };
  xdg.configFile."macchina" = {
    source = ../../macchina/.config/macchina;
    recursive = true;
  };

  # Mail and calendar
  xdg.configFile."aerc" = {
    source = ../../aerc/.config/aerc;
    recursive = true;
  };
  xdg.configFile."khal" = {
    source = ../../khal/.config/khal;
    recursive = true;
  };
  xdg.configFile."vdirsyncer" = {
    source = ../../vdirsyncer/.config/vdirsyncer;
    recursive = true;
  };

  # Media
  xdg.configFile."rmpc" = {
    source = ../../rmpc/.config/rmpc;
    recursive = true;
  };

  # Other utilities
  xdg.configFile."lsd" = {
    source = ../../lsd/.config/lsd;
    recursive = true;
  };
  xdg.configFile."oh-my-posh" = {
    source = ../../oh-my-posh/.config/oh-my-posh;
    recursive = true;
  };
  xdg.configFile."prettierrc.json".source = ../../prettierd/.config/prettierrc.json;
  xdg.configFile."wiki-tui" = {
    source = ../../wiki-tui/.config/wiki-tui;
    recursive = true;
  };

  # Binaries and scripts
  home.file.".local/scripts" = {
    source = ../../binaries/.local/scripts;
    recursive = true;
  };


  # Systemd user services
  xdg.configFile."systemd/user" = {
    source = ../../systemd/.config/systemd/user;
    recursive = true;
  };

  # Terminfo
  xdg.configFile."terminfo" = {
    source = ../../terminfo/.config/terminfo;
    recursive = true;
  };

  # GnuPG
  xdg.dataFile."gnupg" = {
    source = ../../gnupg/.local/share/gnupg;
    recursive = true;
  };

  # Doom Emacs
  home.file.".doom.d" = {
    source = ../../doom/.doom.d;
    recursive = true;
  };

  # Claude CLI
  home.file.".claude" = {
    source = ../../claude/.claude;
    recursive = true;
  };

}

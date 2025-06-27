{
  pkgs,
  pkgs-unstable,
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

  services.git-sync = {
    enable = true;
    repositories = {
      Obsidian = {
        path = /home/echo/Obsidian;
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

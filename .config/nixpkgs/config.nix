{
  packageOverrides = pkgs: with pkgs; {
    myEnv = pkgs.buildEnv {
      name = "myEnv";
      paths = [
        tmux
        neovim
        starship
        fnm
        fzf
        go
        rustup
        zoxide
        direnv
        macchina
        bat
        lazygit
        fd
        ripgrep
        helix
        htop
        exa
        alacritty
        luarocks
        difftastic
        tree-sitter
        zig
        zstd
        luarocks
        (python3.withPackages (
          ps: with ps; [
            pip
            black
            pytest
          ]
        ))
      ];
    };
  };
}

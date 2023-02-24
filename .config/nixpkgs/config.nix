{
  packageOverrides = pkgs: with pkgs; rec {
    myProfile = writeText "my-profile" ''
      export PATH=$HOME/.nix-profile/bin:/nix/var/profiles/default/bin:$PATH
      export MANPATH=$HOME/.nix-profile/share/man:/nix/var/profiles/default/share/man:$MANPATH
    '';
    myEnv = pkgs.buildEnv {
      name = "myEnv";
      paths = [
        (runCommand "profile" {} ''
          mkdir -p $out/etc/profile.d
          cp ${myProfile} $out/etc/profile.d/my-profile.sh
        '')
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
        grc
        erdtree
        (python3.withPackages (
          ps: with ps; [
            pip
            black
            pytest
          ]
        ))
      ];
      pathsToLink = ["/share" "/bin" "/etc"];
      extraOutputsToInstall = ["man" "doc"];
    };
  };
}

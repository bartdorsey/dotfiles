{
  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; rec {
    myProfile = writeText "my-profile" ''
      export PATH=$HOME/.nix-profile/bin:/nix/var/profiles/default/bin:$PATH
      export MANPATH=$HOME/.nix-profile/share/man:/nix/var/profiles/default/share/man:$MANPATH
      export PKG_CONFIG_PATH=$HOME/.nix-profile/lib/pkgconfig
    '';
    myEnv = pkgs.buildEnv {
      name = "myEnv";
      paths = [
        (runCommand "profile" {} ''
          mkdir -p $out/etc/profile.d
          cp ${myProfile} $out/etc/profile.d/my-profile.sh
        '')
        neovim
        nodejs
        nodePackages.markdownlint-cli
        nodePackages.cspell
        nodePackages.yarn
        nodePackages.pnpm
        nodePackages.neovim
        efm-langserver
        chafa
        sc-im
        tree
        curl
        tmux
        starship
        fzf
        go
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
        gitui
        pkg-config
        openssl.dev
        wget
        aerc
        pandoc
        wiki-tui
        php82
        php82Packages.composer
        btop
        zellij
        gcc
        du-dust
        twitch-tui
        _1password
        zip
        unzip
        gnupg
        pass
        dogdns
        xh
        sd
        procs
        teip
        git
        git-lfs
        topgrade
        choose
        stow
        (python3.withPackages (
          ps: with ps; [
            pip
            black
            pytest
            pynvim
          ]
        ))
      ];
      pathsToLink = ["/share" "/bin" "/etc" "/include" "/lib"];
      extraOutputsToInstall = ["man" "doc"];
    };
  };
}

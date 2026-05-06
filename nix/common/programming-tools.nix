{
  pkgs,
  pkgs-unstable,
  ...
}: {
  environment.systemPackages =
    (with pkgs; [
      # Python
      (python313.withPackages (ps:
        with ps; [
          pip
          flake8
          black
          pipx
          ipython
          pgcli
          mypy
          vdirsyncer
        ]))

      # JavaScript / Node
      bun
      deno
      nodejs_24
      pnpm
      yarn

      # Go
      go
      gopls
      gotools

      # OCaml
      ocaml
      ocamlPackages.findlib
      ocamlPackages.ocaml-lsp
      ocamlformat

      # Lua
      lua
      lua-language-server
      luarocks

      # Perl
      perl
      perlnavigator

      # PHP
      php
      php83Packages.composer

      # Other Languages
      gleam
      jdk21
      julia
      lean4
      rustup
      uv

      # Language Servers
      basedpyright
      bash-language-server
      docker-language-server
      emmet-language-server
      intelephense
      nixd
      postgres-language-server
      pyright
      tailwindcss-language-server
      vim-language-server

      # Formatters & Linters
      alejandra
      beautysh
      codespell
      djlint
      markdownlint-cli
      markdownlint-cli2
      prettier
      prettierd
      ruff
      stylua
      yamlfmt
    ])
    ++ (with pkgs-unstable; [
      tree-sitter
    ]);
}

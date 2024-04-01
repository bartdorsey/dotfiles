return {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    event = { "BufReadPre" },
    config = function()
        -- [[ Configure Treesitter ]]
        -- See `:help nvim-treesitter`
        --
        require("nvim-treesitter.install").prefer_git = false
        require("nvim-treesitter.configs").setup({
            modules = {},
            ignore_install = {},
            autotag = {
                enable = true,
            },
            sync_install = true,
            auto_install = false,
            ensure_installed = {
                "astro",
                "bash",
                "c",
                "cmake",
                "comment",
                "cpp",
                "css",
                "diff",
                "dockerfile",
                "gitattributes",
                "git_config",
                "git_rebase",
                "gitignore",
                "graphql",
                "go",
                "haskell",
                "html",
                "htmldjango",
                "http",
                "java",
                "javascript",
                "jsdoc",
                "json",
                "jsonc",
                "kdl",
                "latex",
                "lua",
                "luadoc",
                "llvm",
                "make",
                "markdown",
                "markdown_inline",
                "nix",
                "ocaml",
                "ocaml_interface",
                "perl",
                "php",
                "phpdoc",
                "prisma",
                "python",
                "rasi",
                "ruby",
                "rust",
                "scss",
                "sql",
                "svelte",
                "toml",
                "tsx",
                "typescript",
                "twig",
                "vim",
                "vimdoc",
                "vue",
                "yaml",
                "zig",
            },

            highlight = { enable = true },
            indent = { enable = true },
        })

        local parser_config =
            require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.gotmpl = {
            install_info = {
                url = "https://github.com/ngalaiko/tree-sitter-go-template",
                files = { "src/parser.c" },
            },
            filetype = "gotmpl",
            used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl" },
        }

        -- Custom treesitter injections
        vim.treesitter.query.set(
            "python",
            "injections",
            [[ (call function:
                    (attribute
                        object: (identifier)
                        attribute: (identifier) @method
                            (#eq? @method "execute"))
                    arguments:
                    (argument_list
                        (string
                            (string_content) @injection.content
                                (#set! injection.language "sql"))))
            ]]
        )
    end,
}

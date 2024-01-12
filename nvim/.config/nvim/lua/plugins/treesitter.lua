return {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "windwp/nvim-ts-autotag",
        "nvim-treesitter/nvim-treesitter-textobjects",
        -- "HiPhish/nvim-ts-rainbow2",
    },
    build = ":TSUpdate",
    event = { "BufReadPre" },
    config = function()
        -- [[ Configure Treesitter ]]
        -- See `:help nvim-treesitter`
        --
        require("nvim-treesitter.install").prefer_git = false
        require("nvim-treesitter.configs").setup({
            ignore_install = {},
            autotag = {
                enable = true,
            },
            sync_install = false,
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
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<c-space>",
                    node_incremental = "<c-space>",
                    scope_incremental = "<c-s>",
                    node_decremental = "<c-backspace>",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = "@class.outer",
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>a"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>A"] = "@parameter.inner",
                    },
                },
            },
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

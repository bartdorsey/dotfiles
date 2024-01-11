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
            -- rainbow = {
            --     enable = true,
            --     query = "rainbow-parens",
            --     strategy = require("ts-rainbow.strategy.global"),
            -- },
            -- Add languages to be installed here that you want installed for treesitter
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

        -- Set highlight groups for nvim-ts-rainbow2 for catppuccin
        -- vim.cmd("highlight TSRainbowRed guifg=#f38ba8")
        -- vim.cmd("highlight TSRainbowYellow guifg=#f9e2af")
        -- vim.cmd("highlight TSRainbowBlue guifg=#89b4fa")
        -- vim.cmd("highlight TSRainbowOrange guifg=#fab387")
        -- vim.cmd("highlight TSRainbowGreen guifg=#a6e3a1")
        -- vim.cmd("highlight TSRainbowViolet guifg=#cba6f7")
        -- vim.cmd("highlight TSRainbowCyan guifg=#94e2d5")
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
    end,
}

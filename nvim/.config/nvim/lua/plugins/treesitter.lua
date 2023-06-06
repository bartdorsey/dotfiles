return {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = function()
        pcall(require("nvim-treesitter.install").update({ with_sync = true }))
    end,
    dependencies = {
        "windwp/nvim-ts-autotag",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "HiPhish/nvim-ts-rainbow2",
    },
    event = { "BufReadPre" },
    config = function()
        -- [[ Configure Treesitter ]]
        -- See `:help nvim-treesitter`
        require("nvim-treesitter.configs").setup({
            autotag = {
                enable = true,
            },
            rainbow = {
                enable = true,
                query = "rainbow-parens",
                strategy = require("ts-rainbow.strategy.global"),
            },
            -- Add languages to be installed here that you want installed for treesitter
            ensure_installed = {
                "astro",
                "bash",
                "c",
                "comment",
                "cpp",
                "css",
                "git_rebase",
                "gitignore",
                "go",
                "go",
                "vimdoc",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "nix",
                "prisma",
                "python",
                "rust",
                "scss",
                "svelte",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "yaml",
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
    end,
}

return {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
        -- LSP Support
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },

        -- Null ls
        { "jay-babu/mason-null-ls.nvim" },
        {
            "jose-elias-alvarez/null-ls.nvim",
        },

        -- Autocompletion
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },
        { "onsails/lspkind-nvim" },
        { "zbirenbaum/copilot-cmp" },
        { "hrsh7th/cmp-emoji" },

        -- Snippets
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },

        -- Diagnostics
        { "ErichDonGubler/lsp_lines.nvim" },

        -- Rust tools
        { "simrat39/rust-tools.nvim" },

        {
            "folke/neodev.nvim",
            ft = "lua",
            config = function()
                require("neodev").setup()
            end,
        },
    },
    cmd = { "Mason" },
    event = { "BufReadPre" },
    config = function()
        -- LSP settings.
        local lsp = require("lsp-zero")

        -- Formatting keybind
        vim.keymap.set(
            "n",
            "<leader>ff",
            "<cmd>LspZeroFormat<cr>",
            { desc = "Format File" }
        )

        -- Start with the minimal preset
        lsp.preset("minimal")

        -- Set some prefs
        lsp.set_preferences({
            suggest_lsp_servers = true,
            setup_servers_on_start = true,
            set_lsp_keymaps = true,
            configure_diagnostics = true,
            cmp_capabilities = true,
            manage_nvim_cmp = true,
            call_servers = "local",
        })

        lsp.set_sign_icons({
            error = "✘",
            warn = "▲",
            hint = "⚑",
            info = "",
        })

        -- Ensure that mason installs these
        lsp.ensure_installed({
            "tsserver",
            "eslint",
            "lua_ls",
            "rust_analyzer",
            "emmet_ls",
            "pyright",
            "marksman",
            "bashls",
            "jsonls",
            "ocamllsp",
            "ruff_lsp",
        })

        -- Autoformat on Save
        lsp.format_on_save({
            format_opts = {
                async = false,
                timeout_ms = 10000,
            },
            servers = {
                ["null-ls"] = {
                    "html",
                    "javascriptreact",
                    "typescriptreact",
                    "typescript",
                    "javascript",
                    "json",
                    "markdown",
                    "ocaml",
                    "css",
                    "scss",
                    "yaml",
                    "php",
                    "lua",
                    "zsh",
                    "sh",
                    "python",
                    "rust",
                },
            },
        })

        -- Emmet
        lsp.configure("emmet_ls", {
            settings = {
                filetypes = {
                    "html",
                    "typescriptreact",
                    "javascriptreact",
                    "css",
                    "sass",
                    "scss",
                    "less",
                },
            },
        })

        -- require("rust-tools").setup({
        --     tools = {
        --         inlay_hints = {
        --             only_current_line = true,
        --         },
        --     },
        -- })

        -- Rust analyzer
        lsp.configure("rust_analyzer", {
            settings = {
                ["rust-analyzer"] = {
                    cargo = {
                        features = "all",
                    },
                    checkOnSave = true,
                    check = {
                        command = "clippy",
                    },
                },
            },
        })

        -- Pyright
        lsp.configure("pyright", {
            settings = {
                typeCheckingMode = "strict",
                reportMissingTypeStubs = true,
            },
        })

        lsp.configure("yamlls", {
            settings = {
                yaml = {
                    format = {
                        enable = true,
                    },
                    validate = true,
                    hover = true,
                    schemas = {
                        ["/tools/glossary-yaml-to-xml/docs/glossary-schema.yaml"] = "**/glossary.yml",
                        ["schema.yml"] = "**/question.yml",
                    },
                },
            },
        })

        -- Setup CMP
        require("plugins/lsp/cmp")

        -- Finish setting up LSP
        lsp.on_attach(require("plugins/lsp/onattach"))
        lsp.nvim_workspace()
        lsp.setup()

        -- Setup null ls
        require("plugins/lsp/null-ls")
    end,
}

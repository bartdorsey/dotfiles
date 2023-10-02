return {
    "neovim/nvim-lspconfig",
    dependencies = {
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

        -- Schema Store
        { "b0o/schemastore.nvim" },

        -- Snippets
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },

        -- Diagnostics
        { "ErichDonGubler/lsp_lines.nvim" },

        -- Rust tools
        -- { "simrat39/rust-tools.nvim" },

        {
            "folke/neodev.nvim",
            ft = "lua",
            config = function()
                require("neodev").setup()
            end,
        },
    },
    event = { "BufReadPre" },
    config = function()
        -- LSP settings.
        local lsp = require("lspconfig");

        -- Formatting keybind
        vim.keymap.set(
            "n",
            "<leader>ff",
            vim.lsp.buf.format,
            { desc = "Format File" }
        )

        -- Format on save
        vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

        -- Emmet
        lsp.emmet_ls.setup({
            filetypes = {
                "html",
                "typescriptreact",
                "javascriptreact",
                "css",
                "sass",
                "scss",
                "less",
            },
        })

        -- TypeScript
        lsp.tsserver.setup({
            filetypes = {
                "typescript",
                "typescriptreact",
                "javascript",
                "javascriptreact",
            },
        })

        -- JSON
        lsp.jsonls.setup({
            json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
            },
        })

        -- Go
        lsp.gopls.setup({})

        -- require("rust-tools").setup({
        --     tools = {
        --         inlay_hints = {
        --             only_current_line = true,
        --         },
        --     },
        -- })

        lsp.perlnavigator.setup({
            perlimportsTidyEnabled = true,
            perlimportsLineEnabled = true,
            includePaths = { "./lib" },
        })

        -- Rust analyzer
        lsp.rust_analyzer.setup({
            ["rust-analyzer"] = {
                cargo = {
                    features = "all",
                },
                checkOnSave = true,
                check = {
                    command = "clippy",
                },
            },
        })

        -- Grammarly
        lsp.grammarly.setup({
            init_options = {
                clientId = "client_NsbE8hVFaZqeCbExsWktzG",
            },
        })

        -- Pyright
        lsp.pyright.setup({
            typeCheckingMode = "strict",
            reportMissingTypeStubs = true,
        })

        lsp.yamlls.setup({
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
        })

        -- Lua
        lsp.lua_ls.setup({
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace"
                    }
                }
            }
        })

        -- Setup CMP
        require("plugins/lsp/cmp")

        -- on attach
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = require("plugins/lsp/onattach")
        })

    end,
}

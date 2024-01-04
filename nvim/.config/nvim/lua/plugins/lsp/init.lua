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

        -- EFM Configs
        { "creativenull/efmls-configs-nvim" },

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
    config = function()
        -- LSP settings.
        local lsp = require("lspconfig")

        -- Capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport =
            true

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

        -- Perl
        -- lsp.perlnavigator.setup({
        --     perlimportsTidyEnabled = true,
        --     perlimportsLineEnabled = true,
        --     includePaths = { "./lib" },
        -- })

        lsp.perlls.setup({})

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

        -- -- Grammarly
        -- lsp.grammarly.setup({
        --     init_options = {
        --         clientId = "client_NsbE8hVFaZqeCbExsWktzG",
        --     },
        -- })

        -- Ruff lsp
        lsp.ruff_lsp.setup({})

        -- Python
        lsp.jedi_language_server.setup({})

        -- Pyright
        lsp.pyright.setup({
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "basic",
                        autoSearchPaths = true,
                        diagnosticMode = "openFilesOnly",
                        useLibraryCodeForTypes = true,
                        reportMissingTypeStubs = true,
                    },
                },
            },
        })

        lsp.ansiblels.setup({})

        lsp.yamlls.setup({
            yaml = {
                schemaStore = {
                    enable = true,
                },
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
                        callSnippet = "Replace",
                    },
                    workspace = {
                        checkThirdParty = false,
                    },
                },
            },
        })
        -- Bash
        lsp.bashls.setup({
            filetypes = { "sh", "zsh" },
        })

        -- CSS
        lsp.cssls.setup({
            capabilities = capabilities,
        })

        -- CSS Modules
        lsp.cssmodules_ls.setup({})

        -- Tailwind
        lsp.tailwindcss.setup({})

        -- HTML
        lsp.html.setup({
            capabilities = capabilities,
        })
        -- ESLint
        lsp.eslint.setup({})

        -- Dockerfile
        lsp.dockerls.setup({})

        -- Ocaml
        lsp.ocamllsp.setup({})

        -- vimscript
        lsp.vimls.setup({})

        local eslint = require("efmls-configs.linters.eslint")
        local prettier = require("efmls-configs.formatters.prettier")
        local stylua = require("efmls-configs.formatters.stylua")
        local languages = {
            typescript = { eslint, prettier },
            lua = { stylua },
        }

        -- efm
        local efmls_config = {
            filetypes = vim.tbl_keys(languages),
            settings = {
                rootMarkers = { ".git/" },
                languages = languages,
            },
            init_options = {
                hover = true,
                completion = true,
                codeAction = true,
                documentFormatting = true,
                documentRangeFormatting = true,
                publishDiagnostics = true,
            },
        }

        lsp.efm.setup(vim.tbl_extend("force", efmls_config, {}))

        -- SQL
        lsp.sqlls.setup({})

        -- Setup CMP
        require("plugins/lsp/cmp")

        -- mouse hover stuff
        -- vim.api.nvim_set_keymap(
        --     "n",
        --     "<LeftMouse>",
        --     '<LeftMouse><cmd>lua vim.lsp.buf.hover({border = "single"})<CR>',
        --     { noremap = true, silent = true }
        -- )
        --
        -- vim.api.nvim_set_keymap(
        --     "n",
        --     "<RightMouse>",
        --     "<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>",
        --     { noremap = true, silent = true }
        -- )

        -- on attach
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = require("plugins/lsp/onattach"),
        })
    end,
}

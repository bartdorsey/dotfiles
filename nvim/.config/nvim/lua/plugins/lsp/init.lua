return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Autocompletion
        { "hrsh7th/nvim-cmp" }, -- autocompletion plugin
        { "hrsh7th/cmp-buffer" }, -- buffer words source for cmp
        { "hrsh7th/cmp-path" }, -- path source for cmp
        { "hrsh7th/cmp-omni" }, -- omnifunc source for cmp
        { "hrsh7th/cmp-cmdline" }, -- cmdline completion for cmp
        { "hrsh7th/cmp-emoji" }, -- emoji completions for cmp
        { "hrsh7th/cmp-nvim-lsp" }, -- lsp completions for cmp
        { "hrsh7th/cmp-nvim-lua" }, -- completions for neovim lua api
        { "saadparwaiz1/cmp_luasnip" }, -- luasnip completions for cmp
        { "onsails/lspkind-nvim" }, -- icons for completion menus
        { "zbirenbaum/copilot-cmp" }, -- github copilot cmp completions

        -- Schema Store
        { "b0o/schemastore.nvim" },

        -- Snippets
        { "L3MON4D3/LuaSnip" },

        -- Diagnostics
        { "ErichDonGubler/lsp_lines.nvim" },

        -- EFM Configs
        { "creativenull/efmls-configs-nvim" },

        -- Rust tools
        { "simrat39/rust-tools.nvim" },

        -- For developing neovim plugins and configs
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

        -- Perl
        lsp.perlnavigator.setup({
            perlimportsTidyEnabled = true,
            perlimportsLineEnabled = true,
            includePaths = { "./lib" },
        })

        lsp.perlls.setup({})

        -- Rust
        require("rust-tools").setup({
            tools = {
                inlay_hints = {
                    only_current_line = true,
                },
            },
        })

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
        lsp.grammarly.setup({
            init_options = {
                clientId = "client_NsbE8hVFaZqeCbExsWktzG",
            },
        })

        -- Python
        --- Ruff lsp
        lsp.ruff_lsp.setup({})

        --- Jedi
        lsp.jedi_language_server.setup({})

        --- Pyright
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

        -- Ansible
        lsp.ansiblels.setup({})

        -- YAML
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

        -- EFM Linters
        local eslint = require("efmls-configs.linters.eslint")
        local prettier = require("efmls-configs.formatters.prettier")
        local stylua = require("efmls-configs.formatters.stylua")
        local languages = {
            typescript = { eslint, prettier },
            lua = { stylua },
        }

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

        -- on attach
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = require("plugins/lsp/onattach"),
        })
    end,
}

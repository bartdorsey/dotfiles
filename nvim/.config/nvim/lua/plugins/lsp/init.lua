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
        {
            "nvim-orgmode/orgmode",
        },
    },
    config = function()
        local which = require("util").which
        -- LSP settings.
        local lsp = require("lspconfig")

        -- Capabilities
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Emmet
        if which("emmet-language-server") then
            lsp.emmet_ls.setup({
                capabilities = capabilities,
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
        end

        -- nixd
        if which("nixd") then
            lsp.nixd.setup({
                capabilities = capabilities,
            })
        end

        -- JavaScript
        if which("biome") then
            lsp.biome.setup({
                capabilities = capabilities,
            })
        end

        -- TypeScript
        if which("typescript-language-server") then
            lsp.tsserver.setup({
                capabilities = capabilities,
                filetypes = {
                    "typescript",
                    "typescriptreact",
                    "javascript",
                    "javascriptreact",
                },
            })
        end

        -- JSON
        if which("vscode-json-language-server") then
            lsp.jsonls.setup({
                capabilities = capabilities,
                json = {
                    schemas = require("schemastore").json.schemas(),
                    validate = { enable = true },
                },
            })
        end

        -- Go
        if which("gopls") then
            lsp.gopls.setup({
                capabilities = capabilities,
            })
        end

        -- Perl
        if which("perlnavigator") then
            lsp.perlnavigator.setup({
                capabilities = capabilities,
                perlimportsTidyEnabled = true,
                perlimportsLineEnabled = true,
                includePaths = { "./lib" },
            })
        end

        lsp.perlls.setup({})

        -- Rust
        if which("rustc") then
            require("rust-tools").setup({
                capabilities = capabilities,
                tools = {
                    inlay_hints = {
                        only_current_line = true,
                    },
                },
            })
        end

        if which("rust-analyzer") then
            lsp.rust_analyzer.setup({
                capabilities = capabilities,
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
        end

        -- -- Grammarly
        lsp.grammarly.setup({
            capabilities = capabilities,
            init_options = {
                clientId = "client_NsbE8hVFaZqeCbExsWktzG",
            },
        })

        -- Python
        --- Ruff lsp
        if which("ruff-lsp") then
            lsp.ruff_lsp.setup({
                capabilities = capabilities,
            })
        end

        --- Jedi
        if which("jedi_language_server") then
            lsp.jedi_language_server.setup({
                capabilities = capabilities,
            })
        end

        --- Pyright
        if which("pyright-langserver") then
            lsp.pyright.setup({
                capabilities = capabilities,
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
        end

        -- Ansible
        if which("ansible-language-server") then
            lsp.ansiblels.setup({
                capabilities = capabilities,
            })
        end

        -- YAML
        if which("yaml-language-server") then
            lsp.yamlls.setup({
                capabilities = capabilities,
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
        end

        -- Lua
        if which("lua-language-server") then
            lsp.lua_ls.setup({
                capabilities = capabilities,
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
        end

        -- Bash
        if which("bash-language-server") then
            lsp.bashls.setup({
                capabilities = capabilities,
                filetypes = { "sh", "zsh" },
            })
        end

        -- CSS
        if which("vscode-css-language-server") then
            lsp.cssls.setup({
                capabilities = capabilities,
            })
        end

        -- CSS Modules
        if which("cssmodules-language-server") then
            lsp.cssmodules_ls.setup({
                capabilities = capabilities,
            })
        end

        -- Tailwind
        if which("tailwindcss-language-server") then
            lsp.tailwindcss.setup({
                capabilities = capabilities,
            })
        end

        -- HTML
        if which("vscode-html-language-server") then
            lsp.html.setup({
                capabilities = capabilities,
            })
        end

        -- ESLint
        if which("vscode-eslint-language-server") then
            lsp.eslint.setup({
                capabilities = capabilities,
            })
        end

        -- Dockerfile
        if which("docker-langserver") then
            lsp.dockerls.setup({
                capabilities = capabilities,
            })
        end

        -- Ocaml
        if which("ocamllsp") then
            lsp.ocamllsp.setup({
                capabilities = capabilities,
            })
        end

        -- vimscript
        if which("vim-language-server") then
            lsp.vimls.setup({
                capabilities = capabilities,
            })
        end

        -- EFM Linters
        if which("efm-langserver") then
            local eslint = require("efmls-configs.linters.eslint")
            local prettier = require("efmls-configs.formatters.prettier")
            local stylua = require("efmls-configs.formatters.stylua")
            local languages = {
                typescript = { eslint, prettier },
                lua = { stylua },
            }

            local efmls_config = {
                capabilities = capabilities,
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
        end

        -- -- SQL
        -- lsp.sqlls.setup({
        --     capabilities = capabilities,
        -- })

        -- Setup CMP
        require("plugins/lsp/cmp")

        -- on attach
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = require("plugins/lsp/onattach"),
        })

        -- Diagnostic signs
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "",
                    [vim.diagnostic.severity.WARN] = "",
                },
            },
        })

        -- LspReport
        vim.api.nvim_create_user_command("LspReport", function()
            local servers = {}
            local configs = require("lspconfig.configs")
            for server, config in pairs(configs) do
                if config.manager ~= nil then
                    table.insert(servers, {
                        name = server,
                        capabilities = config.manager.config.capabilities,
                    })
                end
            end
            local buf = vim.api.nvim_create_buf(true, true)
            vim.api.nvim_buf_set_lines(
                buf,
                0,
                0,
                true,
                vim.split(vim.inspect(servers), "\n")
            )
            vim.api.nvim_set_current_buf(buf)
        end, {})
    end,
}

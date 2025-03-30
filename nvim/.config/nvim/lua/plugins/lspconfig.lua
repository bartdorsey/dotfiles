-- Function which checks if a lsp binary exists
local function lsp_binary_exists(server_config)
    local valid_config = server_config.document_config
        and server_config.document_config.default_config
        and type(server_config.document_config.default_config.cmd) == "table"
        and #server_config.document_config.default_config.cmd >= 1

    if not valid_config then
        return false
    end

    local binary = server_config.document_config.default_config.cmd[1]

    local found = vim.fn.executable(binary) == 1
    if not found then
        vim.notify("Missing LSP:" .. binary)
    end
    return found
end

return {
    "neovim/nvim-lspconfig",
    cond = os.getenv("DEVMODE") ~= nil,
    dependencies = {
        -- Autocompletion
        { "hrsh7th/cmp-nvim-lsp" },

        -- Schema Store
        { "b0o/schemastore.nvim" },

        -- Diagnostics
        -- { "jmsegrev/lsp_lines.nvim" },

        -- For developing neovim plugins and configs
        {
            "folke/neodev.nvim",
            ft = "lua",
            config = true,
        },
        {
            "nvim-orgmode/orgmode",
        },
        -- python
        {
            "linux-cultist/venv-selector.nvim",
        },
        {
            "echasnovski/mini.nvim",
        },
        {
            "williamboman/mason.nvim",
        },
    },
    config = function()
        -- LSP settings.
        local lsp = require("lspconfig")
        -- Capabilities
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities()

        local servers = {
            emmet_language_server = {
                filetypes = {
                    "html",
                    "typescriptreact",
                    "javascriptreact",
                    "css",
                    "sass",
                    "scss",
                    "less",
                },
                init_options = {
                    showSuggestionsAsSnippets = true,
                },
            },
            nixd = {},
            ts_ls = {
                filetypes = {
                    "typescript",
                    "typescriptreact",
                    "javascript",
                    "javascriptreact",
                },
                root_dir = require("lspconfig").util.root_pattern(
                    "tsconfig.json",
                    "jsconfig.json",
                    "package.json"
                ),
                single_file_support = true,
            },
            jsonls = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                    validate = { enable = true },
                },
            },
            gopls = {},
            gleam = {},
            perlnavigator = {
                perlimportsTidyEnabled = true,
                perlimportsLineEnabled = true,
                includePaths = { "./lib" },
            },
            perlls = {},
            rust_analyzer = {
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
            ruff = {
                init_options = {
                    settings = {
                        lineLength = 80,
                    },
                },
            },
            pyright = {
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "basic",
                            autoSearchPaths = true,
                            diagnosticMode = "workspace",
                            useLibraryCodeForTypes = true,
                            reportMissingTypeStubs = false,
                        },
                    },
                },
            },
            ansiblels = {},
            yamlls = {
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
                        ["https://raw.githubusercontent.com/espanso/espanso/dev/schemas/config.schema.json"] = "**/espanso/config/*.yml",
                        ["https://raw.githubusercontent.com/espanso/espanso/dev/schemas/match.schema.json"] = "**/espanso/match/*.yml",
                    },
                },
            },
            lua_ls = {
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
            },
            bashls = {
                filetypes = { "sh", "zsh" },
            },
            cssls = {},
            cssmodules_ls = {},
            tailwindcss = {},
            denols = {},
            html = {},
            eslint = {},
            dockerls = {},
            ocamllsp = {},
            vimls = {},
            intelephense = {},
            sqlls = {},
            powershell_es = {},
        }

        vim.g.markdown_fenced_languages = {
            "ts=typescript",
        }

        -- Main loop to initialize the servers
        for name, config in pairs(servers) do
            if lsp_binary_exists(lsp[name]) then
                lsp[name].setup(vim.tbl_extend("force", config, {
                    capabilities = capabilities,
                }))
            end
        end

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

        -- require("lsp_lines").setup()

        local _border = "single"

        --- @param err? lsp.ResponseError
        --- @param result any
        --- @param ctx any
        --- @param config? table
        vim.lsp.handlers["textDocument/hover"] = function(
            err,
            result,
            ctx,
            config
        )
            config = config or {}
            config.border = _border
            vim.lsp.handlers.hover(err, result, ctx, config)
        end

        vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = _border,
            })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("LspConfig", {}),

            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client == nil then
                    return
                end

                -- Enable inlay hints if it's available
                if vim.lsp.inlay_hint then
                    if
                        client ~= nil
                        and client.server_capabilities.inlayHintProvider
                    then
                        vim.lsp.inlay_hint.enable(true)
                    end
                end
            end,
        })
    end,
}

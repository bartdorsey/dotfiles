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
    event = { "BufEnter", "BufNewFile" },
    dependencies = {
        -- Completion
        {
            "saghen/blink.cmp",
        },
        -- Schema Store
        { "b0o/schemastore.nvim" },

        -- For developing neovim plugins and configs
        {
            "folke/lazydev.nvim",
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

        --- @type vim.lsp.ClientConfig[]
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
                init_options = {
                    preferences = {
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                        importModuleSpecifierPreference = "non-relative",
                    },
                },
                single_file_support = true,
            },
            jsonls = {
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                    },
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
            basedpyright = {
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "recommended",
                            autoSearchPaths = true,
                            diagnosticMode = "workspace",
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            },
            ansiblels = {},
            yamlls = {
                settings = {
                    yaml = {
                        schemaStore = {
                            enable = false,
                            url = "",
                        },
                        format = {
                            enable = true,
                        },
                        validate = true,
                        completion = true,
                        hover = true,
                        schemas = vim.tbl_extend(
                            "force",
                            require("schemastore").yaml.schemas(),
                            {
                                ["/tools/glossary-yaml-to-xml/docs/glossary-schema.yaml"] = "**/glossary.yml",
                                ["schema.yml"] = "**/question.yml",
                                ["https://raw.githubusercontent.com/espanso/espanso/dev/schemas/config.schema.json"] = "**/espanso/config/*.yml",
                                ["https://raw.githubusercontent.com/espanso/espanso/dev/schemas/match.schema.json"] = "**/espanso/match/*.yml",
                                ["https://git.sr.ht/~johnhamelink/hass-json-schema/blob/main/json-schemas/configuration.json"] = "configuration.yaml",
                            }
                        ),
                    },
                },
            },
            lua_ls = {
                settings = {
                    Lua = {
                        hint = {
                            enable = true,
                            arrayIndex = "Disable",
                        },
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
            html = {
                settings = {
                    html = {
                        format = {
                            wrapAttributes = "force-aligned",
                        },
                    },
                },
            },
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

        local capabilities = require("blink-cmp").get_lsp_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport =
            true

        -- Defer LSP setup until needed - only check binaries when opening relevant files
        local function setup_lsp_on_demand(server_name, server_config)
            -- Get filetypes for this LSP server
            local filetypes = server_config.filetypes
                or lsp[server_name].document_config.default_config.filetypes
                or {}

            if #filetypes == 0 then
                -- Fallback: setup immediately if no filetypes specified
                if lsp_binary_exists(lsp[server_name]) then
                    server_config.capabilities = capabilities
                    lsp[server_name].setup(server_config)
                end
                return
            end

            -- Create autocmd to setup LSP when opening relevant filetypes
            vim.api.nvim_create_autocmd("FileType", {
                pattern = filetypes,
                once = false, -- Allow multiple files of same type
                callback = function()
                    -- Only setup if not already done and binary exists
                    if
                        not lsp[server_name].manager
                        and lsp_binary_exists(lsp[server_name])
                    then
                        server_config.capabilities = capabilities
                        lsp[server_name].setup(server_config)
                    end
                end,
            })
        end

        -- Setup all servers with deferred loading
        for name, config in pairs(servers) do
            setup_lsp_on_demand(name, config)
        end

        local _border = "single"

        -- --- @param err? lsp.ResponseError
        -- --- @param result any
        -- --- @param ctx any
        -- --- @param config? table
        -- vim.lsp.handlers["textDocument/hover"] = function(
        --     err,
        --     result,
        --     ctx,
        --     config
        -- )
        --     config = config or {}
        --     config.border = _border
        --     vim.lsp.handlers.hover(err, result, ctx, config)
        -- end

        -- vim.lsp.handlers["textDocument/signatureHelp"] =
        --     vim.lsp.with(vim.lsp.handlers.signature_help, {
        --         border = _border,
        --     })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("LspConfig", {}),

            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client == nil then
                    return
                end
                if
                    client:supports_method("textDocument/inlayHint", args.buf)
                    or client.server_capabilities.inlayHintProvider
                then
                    vim.notify("Enabling Inlay Hints")
                    vim.lsp.inlay_hint.enable(true)
                end
            end,
        })
    end,
}

return {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
        -- LSP Support
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "WhoIsSethDaniel/mason-tool-installer.nvim" },

        -- Null ls
        { "jay-babu/mason-null-ls.nvim" },
        { "jose-elias-alvarez/null-ls.nvim" },

        -- Autocompletion
        { "hrsh7th/nvim-cmp" },
        { "windwp/nvim-autopairs" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },
        { "onsails/lspkind-nvim" },
        { "zbirenbaum/copilot-cmp" },

        -- Snippets
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },

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

        --  This function gets run when an LSP connects to a particular buffer.
        local on_attach = function(_, bufnr)
            vim.keymap.set(
                "n",
                "<leader>rn",
                vim.lsp.buf.rename,
                { desc = "Rename Symbol" }
            )
            vim.keymap.set(
                "n",
                "<leader>ca",
                vim.lsp.buf.code_action,
                { desc = "Code Action" }
            )

            vim.keymap.set(
                "n",
                "gd",
                vim.lsp.buf.definition,
                { desc = "Goto Definition" }
            )
            vim.keymap.set(
                "n",
                "gr",
                require("telescope.builtin").lsp_references,
                { desc = "Goto References" }
            )
            vim.keymap.set(
                "n",
                "gI",
                vim.lsp.buf.implementation,
                { desc = "Goto Implementation" }
            )
            vim.keymap.set(
                "n",
                "<leader>D",
                vim.lsp.buf.type_definition,
                { desc = "Goto Type Definition" }
            )
            vim.keymap.set(
                "n",
                "<leader>ds",
                require("telescope.builtin").lsp_document_symbols,
                { desc = "Document Smbols" }
            )
            vim.keymap.set(
                "n",
                "<leader>ws",
                require("telescope.builtin").lsp_dynamic_workspace_symbols,
                { desc = "Workspace Symbols" }
            )

            -- Lesser used LSP functionality
            vim.keymap.set(
                "n",
                "gD",
                vim.lsp.buf.declaration,
                { desc = "Goto Declaration" }
            )
            vim.keymap.set(
                "n",
                "<leader>wa",
                vim.lsp.buf.add_workspace_folder,
                { desc = "Workspace Add Folder" }
            )
            vim.keymap.set(
                "n",
                "<leader>wr",
                vim.lsp.buf.remove_workspace_folder,
                { desc = "Workspace Remove Folder" }
            )
            vim.keymap.set("n", "<leader>wl", function()
                require("notify")(
                    vim.inspect(vim.lsp.buf.list_workspace_folders())
                )
            end, { desc = "Workspace List Folders" })

            local function organize_imports()
                local params = {
                    command = "_typescript.organizeImports",
                    arguments = { vim.api.nvim_buf_get_name(0) },
                    title = "",
                }
                vim.lsp.buf.execute_command(params)
            end

            vim.api.nvim_buf_create_user_command(
                bufnr,
                "OrganizeImports",
                organize_imports,
                { desc = "Organize TypeScript Imports" }
            )
        end

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
            sign_icons = {
                error = "✘",
                warn = "▲",
                hint = "⚑",
                info = "",
            },
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
        })

        -- Autoformat on Save
        lsp.format_on_save({
            servers = {
                ["null-ls"] = {
                    "html",
                    "javascriptreact",
                    "typescriptreact",
                    "json",
                    "markdown",
                    "css",
                    "scss",
                    "yaml",
                    "php",
                    "lua",
                    "zsh",
                    "sh",
                },
            },
        })

        -- Configuring LSP Servers

        -- Null ls
        local null_ls = require("null-ls")
        local null_opts = lsp.build_options("null-ls", {})

        null_ls.setup({
            on_attach = function(client, bufn)
                null_opts.on_attach(client, bufn)

                -- Autoformat for null-ls
                vim.api.nvim_create_autocmd("BufWritePre", {
                    callback = function()
                        vim.lsp.buf.format()
                    end,
                })
            end,
            debug = true,
            sources = {
                null_ls.builtins.diagnostics.markdownlint.with({
                    filetypes = { "markdown" },
                }),
                null_ls.builtins.diagnostics.cspell.with({
                    filetypes = { "markdown" },
                }),
                null_ls.builtins.code_actions.cspell.with({
                    filetypes = { "markdown" },
                }),
                null_ls.builtins.completion.spell.with({
                    filetypes = { "markdown" },
                }),
                null_ls.builtins.diagnostics.alex.with({
                    filetypes = { "markdown" },
                }),
                null_ls.builtins.formatting.prettier.with({
                    filetypes = {
                        "html",
                        "json",
                        "yaml",
                        "markdown",
                        "javascript",
                        "typescript",
                        "javascriptreact",
                        "typescriptreact",
                    },
                }),
                null_ls.builtins.formatting.phpcbf,
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.diagnostics.selene,
                null_ls.builtins.code_actions.refactoring.with({
                    filetypes = {
                        "go",
                        "javascript",
                        "lua",
                        "python",
                        "typescript",
                        "javascriptreact",
                        "typescriptreact",
                    },
                }),
                null_ls.builtins.diagnostics.shellcheck,
                null_ls.builtins.code_actions.shellcheck,
                null_ls.builtins.formatting.beautysh,
                null_ls.builtins.diagnostics.zsh,
            },
        })

        -- Mason null-ls
        require("mason-null-ls").setup({
            automatic_installation = true,
            automatic_setup = true,
        })

        require("mason-null-ls").setup_handlers()

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

        -- Pyright
        lsp.configure("pyright", {
            settings = {
                typeCheckingMode = "strict",
                reportMissingTypeStubs = true,
            },
        })

        -- Autopairs
        require("nvim-autopairs").setup({})

        -- CMP
        local cmp = require("cmp")
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ["<CR>"] = cmp.mapping.confirm(),
            -- This makes Escape cancel the autocomplete AND go back to normal mode
            ["<Esc>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.abort()
                    vim.cmd("stopinsert")
                else
                    fallback()
                end
            end, { "i" }),
        })

        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        lsp.setup_nvim_cmp({
            preselect = "none",
            mapping = cmp_mappings,
            sources = {
                { name = "path" },
                { name = "nvim_lsp" },
                { name = "buffer",  keyword_length = 3 },
                { name = "luasnip", keyword_length = 2 },
                { name = "copilot", group_index = 2 },
            },
            formatting = {
                format = require("lspkind").cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,
                    ellipsis_char = "...",
                    symbol_map = {
                        Copilot = "",
                    },
                }),
            },
            completion = {
                completeopt = "menu,menuone,noinsert,noselect",
            },
        })

        -- Finish setting up LSP
        lsp.on_attach(on_attach)
        lsp.nvim_workspace()
        lsp.setup()

        vim.diagnostic.config({
            virtual_text = true,
        })
    end,
}

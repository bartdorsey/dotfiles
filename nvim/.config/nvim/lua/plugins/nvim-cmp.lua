return {
    "hrsh7th/nvim-cmp", -- autocompletion plugin
    cond = os.getenv("DEVMODE") ~= nil,
    dependencies = {
        { "hrsh7th/cmp-buffer" }, -- buffer words source for cmp
        { "hrsh7th/cmp-path" }, -- path source for cmp
        { "hrsh7th/cmp-omni" }, -- omnifunc source for cmp
        { "hrsh7th/cmp-cmdline" }, -- cmdline completion for cmp
        { "hrsh7th/cmp-emoji" }, -- emoji completions for cmp
        { "chrisgrieser/cmp-nerdfont" }, -- nerdfont completions
        { "hrsh7th/cmp-nvim-lsp" }, -- lsp completions for cmp
        { "hrsh7th/cmp-nvim-lsp-signature-help" }, -- lsp function signatures
        { "hrsh7th/cmp-nvim-lua" }, -- completions for neovim lua api
        { "saadparwaiz1/cmp_luasnip" }, -- luasnip completions for cmp
        { "onsails/lspkind-nvim" }, -- icons for completion menus
        { "zbirenbaum/copilot-cmp" }, -- github copilot cmp completions
        {
            "L3MON4D3/LuaSnip",
            config = function()
                require("luasnip").filetype_extend(
                    "markdown",
                    { "snippets.markdown" }
                )
                local config_path = vim.fn.stdpath("config")
                require("luasnip.loaders.from_lua").lazy_load({
                    paths = config_path .. "/snippets",
                })
                require("luasnip.loaders.from_vscode").lazy_load({
                    paths = config_path .. "/snippets",
                })
            end,
        },
    },
    config = function()
        local cmp = require("cmp")

        cmp.setup({
            -- completion
            completion = {
                keyword_length = 3,
            },

            -- Snippets to load
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },

            -- popup window config
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end,
                ["<C-Space>"] = cmp.mapping.complete(),
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
            }),
            -- Sources for completion
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "nvim_lsp_signature_help" },
                { name = "orgmode" },
                { name = "path" },
                { name = "luasnip" },
                {
                    name = "omni",
                    option = {
                        disable_omnifuncs = { "v:lua.vim.lsp.omnifunc" },
                    },
                },
                { name = "emoji" },
                { name = "nerdfont" },
                { name = "vim-dadbod-completion" },
            }, {
                { name = "copilot" },
                { name = "buffer" },
            }),
            -- Formatting the completions in the menu (adds icons)
            formatting = {
                format = require("lspkind").cmp_format({
                    mode = "text_symbol",
                    maxwidth = 50,
                    show_labelDetails = true,
                    ellipsis_char = "...",
                    symbol_map = {
                        Copilot = "",
                    },
                }),
            },
        })
        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
        })
    end,
}

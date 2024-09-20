-- CMP
local cmp = require("cmp")

cmp.setup({
    -- completion
    completion = {
        keyword_length = 1,
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
            option = { disable_omnifuncs = { "v:lua.vim.lsp.omnifunc" } },
        },
        { name = "emoji" },
    }, {
        { name = "copilot" },
        { name = "buffer" },
    }),
    -- Formatting the completions in the menu (adds icons)
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

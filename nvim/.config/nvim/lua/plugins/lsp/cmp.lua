local lsp = require("lspconfig")

-- CMP
local cmp = require("cmp")
cmp.setup({
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
    -- Mappings for completion
    mapping = cmp.mapping.preset.insert({
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
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "buffer", keyword_length = 3 },
        { name = "luasnip", keyword_length = 2 },
        { name = "copilot", group_index = 2 },
        { name = "emoji" },
        {
            name = "omni",
            option = { disable_omnifuncs = { "v:lua.vim.lsp.omnifunc" } },
        },
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

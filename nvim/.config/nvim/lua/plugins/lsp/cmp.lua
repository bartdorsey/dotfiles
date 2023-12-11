local lsp = require("lspconfig")

-- CMP
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
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
    sources = cmp.config.sources({
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "buffer", keyword_length = 3 },
        { name = "luasnip", keyword_length = 2 },
        { name = "copilot", group_index = 2 },
        { name = "emoji" },
    }),
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
    -- completion = {
    --     completeopt = "menu,menuone,noinsert,noselect",
    -- },
})

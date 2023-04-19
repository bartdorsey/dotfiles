local lsp = require("lsp-zero")

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

lsp.setup_nvim_cmp({
    preselect = "none",
    mapping = cmp_mappings,
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "buffer", keyword_length = 3 },
        { name = "luasnip", keyword_length = 2 },
        { name = "copilot", group_index = 2 },
        { name = "emoji" },
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

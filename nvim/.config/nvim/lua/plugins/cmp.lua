return {
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
        local cmp = require('cmp')
        cmp.setup {
            mapping = cmp.mapping.preset.insert({
                ["<CR>"] = cmp.mapping.confirm(),
                ["<Esc>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.abort()
                        vim.cmd("stopinsert")
                    else
                        fallback()
                    end
                end)
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' }
            }, {
                name = "buffer"
            })
        }
    end
}

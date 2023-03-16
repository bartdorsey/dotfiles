return {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
        vim.lsp.buf.format({ timeout_ms = 10000 })
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.markdownlint,
                null_ls.builtins.diagnostics.markdownlint,
                null_ls.builtins.diagnostics.cspell.with({
                    filetypes = { 'markdown' }
                }),
                null_ls.builtins.code_actions.cspell.with({
                    filetypes = { 'markdown' }
                }),
                null_ls.builtins.completion.spell.with({
                    filetypes = { 'markdown' }
                }),
                null_ls.builtins.diagnostics.alex.with({
                    filetypes = { 'markdown' }
                }),
                null_ls.builtins.hover.dictionary.with({
                    filetypes = { 'markdown' }
                }),
                null_ls.builtins.formatting.prettierd.with({
                    filetypes = { "html", "json", "yaml", "markdown" }
                })
            }
        })
    end
}

return {
    'jose-elias-alvarez/null-ls.nvim',
    event = {'BufReadPre'},
    config = function()
        vim.lsp.buf.format({ timeout_ms = 10000 })
        local null_ls = require("null-ls")

        null_ls.setup({
            debug = true,
            sources = {
                null_ls.builtins.diagnostics.markdownlint.with({
                    filetypes = { 'markdown' }
                }),
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
                null_ls.builtins.formatting.prettier.with({
                    filetypes = { "html", "json", "yaml", "markdown", "javascript", "typescript" }
                }),
                null_ls.builtins.formatting.phpcsfixer,
            }
        })
    end
}

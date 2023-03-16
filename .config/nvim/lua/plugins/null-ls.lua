return {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
        vim.lsp.buf.format({ timeout_ms = 10000 })
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.markdownlint,
                null_ls.builtins.diagnostics.markdownlint,
                null_ls.builtins.completion.cspell,
                null_ls.builtins.diagnostics.alex,
                null_ls.builtins.hover.dictionary,
                null_ls.builtins.formatting.prettierd.with({
                    filetypes = { "html", "json", "yaml", "markdown" }
                })
            }
        })
    end
}

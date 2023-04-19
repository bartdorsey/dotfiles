local lsp = require("lsp-zero")
-- Null ls
local null_ls = require("null-ls")
local null_opts = lsp.build_options("null-ls", {})

null_ls.setup({
    on_attach = function(client, bufn)
        null_opts.on_attach(client, bufn)
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
        null_ls.builtins.formatting.black,
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
        null_ls.builtins.formatting.yamlfmt,
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.formatting.xmlformat,
    },
})

-- Mason null-ls
require("mason-null-ls").setup({
    automatic_installation = true,
    automatic_setup = true,
})

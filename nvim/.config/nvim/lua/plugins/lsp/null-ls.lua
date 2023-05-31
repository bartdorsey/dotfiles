local lsp = require("lsp-zero")
-- Null ls
local null_ls = require("null-ls")
local null_opts = lsp.build_options("null-ls", {})

-- Custom HTML validate null-ls setup
local html_validate = {
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "html" },
    generator = null_ls.generator({
        command = "html-validate",
        to_stdin = true,
        from_stderr = false,
        check_exit_code = function(code)
            return code >= 1
        end,
        args = { "--stdin", "-f", "json" },
        format = "json",
        on_output = function(params)
            local N_ERROR = 1
            local N_WARNING = 2
            local N_INFO = 3
            local V_DISABLED = 0
            local V_WARN = 1
            local V_ERROR = 2
            local severity_map = {
                [V_DISABLED] = N_INFO,
                [V_WARN] = N_WARNING,
                [V_ERROR] = N_ERROR,
            }
            local messages = {}
            for _, message in ipairs(params.output[1].messages) do
                vim.print(message)
                table.insert(messages, {
                    message = message.message,
                    source = "html_validate",
                    code = message.ruleId,
                    row = message.line,
                    severity = severity_map[message.severity],
                    col = message.column,
                    end_col = message.column + message.size,
                })
            end
            return messages
        end,
    }),
}

null_ls.setup({
    on_attach = function(client, bufn)
        null_opts.on_attach(client, bufn)
    end,
    debug = true,
    sources = {
        html_validate,
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
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.flake8,
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

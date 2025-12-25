return {
    "stevearc/conform.nvim",
    cond = os.getenv("DEVMODE") ~= nil,
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },
                html = { "prettier" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                javascriptreact = { "prettier" },
                json = { "prettierd" },
                markdown = { "markdownlint" },
                ocaml = { "ocamlformat" },
                htmldjango = { "djlint" },
                nix = { "alejandra" },
                yaml = { "yamlfmt" },
                sh = { "beautysh" },
                ["*"] = { "trim_whitespace", "codespell" },
            },
            format_on_save = {
                -- These options will be passed to conform.format()
                timeout_ms = 500,
                lsp_format = "fallback",
            },
            notify_on_error = false,
            inherit = true,
        })
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}

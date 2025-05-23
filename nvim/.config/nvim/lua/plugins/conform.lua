return {
    "stevearc/conform.nvim",
    cond = os.getenv("DEVMODE") ~= nil,
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" },
                javascriptreact = { "prettierd" },
                json = { "prettierd" },
                markdown = { "markdownlint" },
                ocaml = { "ocamlformat" },
                htmldjango = { "djlint" },
                nix = { "alejandra" },
                yaml = { "yamlfmt" },
                sh = { "beautysh" },
            },
            format_on_save = {
                -- These options will be passed to conform.format()
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        })
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}

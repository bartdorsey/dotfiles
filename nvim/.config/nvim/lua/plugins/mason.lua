return {
    {
        "williamboman/mason.nvim",
        cond = os.getenv("DEVMODE") ~= nil,
        opts = true,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        cond = os.getenv("DEVMODE") ~= nil,
        opts = {
            ensure_installed = {
                "ts_ls",
                "lua_ls",
                "jsonls",
                "eslint",
                "cssls",
                "gopls",
                "emmet_language_server",
                "rust_analyzer",
                "perlnavigator",
                "yamlls",
                "ansiblels",
                "pyright",
                "tailwindcss",
                "bashls",
                "cssmodules_ls",
                "vimls",
            },
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        cond = os.getenv("DEVMODE") ~= nil,
        opts = {
            ensure_installed = {
                "prettierd",
                "djlint",
                "stylua",
                "black",
                "flake8",
            },
        },
    },
}

return {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    config = function()
        print("Setting up Mason")
        require("mason").setup()
        require("mason-lspconfig").setup()
    end,
}

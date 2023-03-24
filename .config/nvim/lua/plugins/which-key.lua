return {
    "folke/which-key.nvim",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = true
        require("which-key").setup {
            window = {
                border = "none",
                position = "bottom",
                winblend = 0
            },
            layout = {
                align = "center"
            },
        }
    end
}

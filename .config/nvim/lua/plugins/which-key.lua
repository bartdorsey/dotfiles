return {
    "folke/which-key.nvim",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = true
        require("which-key").setup {
            window = {
                border = "single",
                position = "bottom",
            },
            layout = {
                align = "center"
            },
        }
    end
}

return {
    "folke/which-key.nvim",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        local wk = require("which-key")

        wk.setup({
            win = {
                border = "none",
                position = "bottom",
                winblend = 0,
            },
            layout = {
                align = "center",
            },
        })
    end,
}

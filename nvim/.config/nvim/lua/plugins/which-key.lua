return {
    "folke/which-key.nvim",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        local wk = require("which-key")

        wk.setup({
            window = {
                border = "none",
                position = "bottom",
                winblend = 0,
            },
            layout = {
                align = "center",
            },
            plugins = {
                marks = false,
                registers = false,
                presets = {
                    operators = false,
                    motions = false,
                    text_objects = false,
                    windows = false,
                    nav = false,
                    z = false,
                    g = false,
                },
            },
        })
    end,
}

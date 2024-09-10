return {
    "folke/which-key.nvim",
    dependencies = {
        "echasnovski/mini.icons",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        local wk = require("which-key")

        wk.setup({
            preset = "modern",
            notify = true,
        })
    end,
}

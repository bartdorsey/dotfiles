return {
    "folke/which-key.nvim",
    enabled = false,
    dependencies = {
        "echasnovski/mini.icons",
        "nvim-tree/nvim-web-devicons",
    },
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
        preset = "modern",
        notify = true,
    },
}

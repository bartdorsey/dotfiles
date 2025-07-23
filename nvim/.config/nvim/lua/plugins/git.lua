return {
    {
        "tpope/vim-fugitive",
    },
    {
        cond = os.getenv("DEVMODE") ~= nil,
        enabled = true,
        "TimUntersberger/neogit",
        cmd = { "Neogit" },
        keys = {
            { "<leader>gs", "<cmd>Neogit<cr>", desc = "Git Status" },
        },
        dependencies = {
            "sindrets/diffview.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            integrations = {
                diffview = true,
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        enabled = true,
        event = "BufReadPre",
        opts = {
            word_diff = false,
            numhl = true,
        },
    },
}

return {
    {
        "tpope/vim-fugitive",
    },
    {
        cond = os.getenv("DEVMODE") ~= nil,
        enabled = true,
        "TimUntersberger/neogit",
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
    -- lazygit.nvim
    {
        "kdheepak/lazygit.nvim",
        enabled = false,
        cmd = { "LazyGit" },
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
        config = true,
    },
}

return {
    {
        "TimUntersberger/neogit",
        dependencies = {
            "sindrets/diffview.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        branch = "nightly",
        config = function()
            require("neogit").setup({
                integrations = {
                    diffview = true,
                },
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
            })
        end,
    },
    -- lazygit.nvim
    {
        "kdheepak/lazygit.nvim",
        cmd = { "LazyGit" },
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
    },
}

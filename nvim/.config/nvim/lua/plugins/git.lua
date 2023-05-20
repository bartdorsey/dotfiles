return {
    {
        "tpope/vim-fugitive",
        event = "BufReadPre",
    },
    {
        "TimUntersberger/neogit",
        dependencies = { "sindrets/diffview.nvim" },
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
                    change = { text = "" },
                    delete = { text = "-" },
                    topdelete = { text = "-" },
                    changedelete = { text = "" },
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

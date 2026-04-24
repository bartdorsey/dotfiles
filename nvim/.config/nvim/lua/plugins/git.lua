return {
    {
        "tpope/vim-fugitive",
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

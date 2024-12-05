return {
    "numtostr/Comment.nvim",
    opts = {
        mappings = {
            basic = true,
            extra = false,
        },
    },
    config = function(_, opts)
        require("Comment").setup(opts)

        vim.api.nvim_set_keymap("n", "<C-_>", "gcc", {
            desc = "Comment",
        })

        vim.api.nvim_set_keymap("v", "<C-_>", "gc", {
            desc = "Comment",
        })
    end,
}

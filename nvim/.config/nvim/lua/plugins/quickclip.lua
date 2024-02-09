return {
    "bartdorsey/quickclip.nvim",
    name = "quickclip",
    -- dir = "~/.config/nvim/local/quickclip.nvim",
    config = function()
        require("quickclip").setup()
        vim.keymap.set(
            "n",
            "<leader>p",
            "<cmd>QuickClip<cr>",
            { desc = "Open QuickClip" }
        )
    end,
}

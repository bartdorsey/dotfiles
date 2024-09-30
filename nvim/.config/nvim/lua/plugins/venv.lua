return {
    "neolooong/whichpy.nvim",
    config = function()
        require("whichpy").setup({})
        vim.keymap.set(
            "n",
            "<leader>fv",
            "<cmd>WhichPy select<cr>",
            { desc = "Select Python Venv" }
        )
    end,
}

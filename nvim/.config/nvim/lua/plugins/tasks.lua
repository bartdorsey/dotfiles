return {
    "stevearc/overseer.nvim",
    opts = {},
    config = function()
        require("overseer").setup({})
        vim.keymap.set("n", "<leader>t", "<cmd>OverseerRun<cr>")
    end,
}

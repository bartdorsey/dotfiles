return {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        {
            "<leader>rr",
            "<Plug>RestNvim<cr>",
            desc = "Run REST command under cursor",
        },
    },
    config = function()
        require("rest-nvim").setup()
    end,
}

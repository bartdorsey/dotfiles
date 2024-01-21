return {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    keys = {
        { "<leader>fD", "<cmd>DevdocsOpen<cr>", desc = "Dev Docs" },
    },
    opts = {},
}

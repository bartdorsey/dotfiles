return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            default_file_explorer = true,
            columns = {
                "icon",
            },
            view_options = {
                show_hidden = true,
            },
        })

        vim.keymap.set(
            "n",
            "-",
            require("oil").open,
            { desc = "Open parent directory" }
        )
    end,
}

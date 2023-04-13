return {
    "jvgrootveld/telescope-zoxide",
    keys = {
        {
            "<leader>sz",
            function()
                require("telescope").extensions.zoxide.list({})
            end,
            desc = "Find Files with Zoxide",
        },
    },
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("telescope").load_extension("zoxide")
    end,
}

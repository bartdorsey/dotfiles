return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        modes = {
            char = {
                jump_labels = true,
            },
        },
        label = {
            before = true,
            after = false,
            rainbow = {
                enabled = true,
                shade = 9,
            },
        },
    },
    keys = {
        {
            "S",
            mode = { "n", "x", "o" },
            function()
                require("flash").treesitter_search()
            end,
            desc = "Flash Treesitter Select",
        },
    },
}

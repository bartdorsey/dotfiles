return {
    cond = true,
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
}

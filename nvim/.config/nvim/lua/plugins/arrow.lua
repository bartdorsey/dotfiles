return {
    "otavioschwanck/arrow.nvim",
    lazy = false,
    config = function()
        require("arrow").setup({
            always_show_path = true,
            leader_key = ";",
            show_icons = true,
        })
    end,
}

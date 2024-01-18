return {
    "otavioschwanck/arrow.nvim",
    config = function()
        require("arrow").setup({
            always_show_path = true,
            leader_key = ";",
            show_icons = true,
        })
    end,
}

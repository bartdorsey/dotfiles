return {
    "OXY2DEV/helpview.nvim",
    dependencies = {
        "catppuccin/nvim",
    },
    lazy = false,
    opts = {
        preview = {
            icon_provider = "devicons",
        },
        vimdoc = {
            headings = {
                heading_1 = {
                    sign = "  ",
                },
                heading_2 = {
                    sign = " 󰉬 ",
                },
                heading_3 = {
                    sign = " 󰉭 ",
                },
                heading_4 = {
                    sign = " 󰉮 ",
                },
            },
        },
    },
}

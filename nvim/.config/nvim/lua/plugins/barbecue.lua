return {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
        local palette = require("rose-pine.palette")
        require("barbecue").setup({
            theme = {
                normal = { bg = palette.overlay },
            },
        })
    end,
}

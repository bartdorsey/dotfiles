-- Theme
return {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavor = "mocha",
            transparent_background = true,
            dim_inactive = {
                enabled = true,
            },
        })
        vim.cmd("colorscheme catppuccin-mocha")
    end,
}

-- Theme
return {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
    config = function()
        require("rose-pine").setup({
            dim_inactive_windows = true,
        })
        vim.cmd("colorscheme rose-pine")
    end,
}

-- Theme
return {
    "rose-pine/neovim",
    config = function()
        require("rose-pine").setup({
            dim_inactive_windows = true,
        })
        vim.cmd("colorscheme rose-pine")
    end,
}

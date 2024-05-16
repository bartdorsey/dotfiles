-- Theme
return {
    "tinted-theming/base16-vim",
    config = function()
        vim.g.base16_colorspace = 256
        vim.g.base16_background_transparent = 1
        vim.cmd("colorscheme base16-rose-pine")
    end,
}

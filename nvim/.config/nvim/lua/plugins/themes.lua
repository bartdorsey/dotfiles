-- Theme
return {
    -- "catppuccin/nvim",
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --     require("catppuccin").setup({
    --         flavor = "mocha",
    --         transparent_background = true,
    --         dim_inactive = {
    --             enabled = true,
    --         },
    --     })
    --     vim.cmd("colorscheme catppuccin-mocha")
    -- end,
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                terminal_colors = true, -- add neovim terminal colors
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = true,
                    emphasis = true,
                    comments = true,
                    operators = false,
                    folds = true,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "hard", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = true,
                transparent_mode = true,
            })
            vim.cmd("colorscheme gruvbox")
        end,
    },
}

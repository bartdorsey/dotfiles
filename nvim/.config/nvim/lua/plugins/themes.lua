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

        -- Make background transparent
        local groups = {
            "Normal",
            "NormalNC",
            "Comment",
            "Constant",
            "Special",
            "Identifier",
            "Statement",
            "PreProc",
            "Type",
            "Underlined",
            "Todo",
            "String",
            "Function",
            "Conditional",
            "Repeat",
            "Operator",
            "Structure",
            "LineNr",
            "NonText",
            "SignColumn",
            "CursorLine",
            "CursorLineNr",
            "StatusLine",
            "StatusLineNC",
            "EndOfBuffer",
        }
        for _, v in ipairs(groups) do
            vim.api.nvim_set_hl(0, v, { bg = "NONE", ctermbg = "NONE" })
        end
    end,
}

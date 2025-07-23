return {
    "HiPhish/rainbow-delimiters.nvim",
    ft = { "lua", "python", "javascript", "typescript", "rust", "go", "java", "cpp", "c", "json", "yaml", "toml", "vim", "bash", "zsh", "html", "css", "scss" },
    main = "rainbow-delimiters.setup",
    config = true,
    init = function()
        -- local colors = require("rose-pine.palette")
        --
        -- -- rainbow delimiters
        -- vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = colors.rose })
        -- vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = colors.gold })
        -- vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = colors.foam })
        -- vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = colors.pine })
        -- vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = colors.iris })
        -- vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = colors.foam })
        -- vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = colors.gold })
    end,
}

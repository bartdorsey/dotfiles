return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "rose-pine/neovim",
        },
        config = function()
            local colors = require("rose-pine.palette")

            -- rainbow delimiters
            vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = colors.rose })
            vim.api.nvim_set_hl(
                0,
                "RainbowDelimiterYellow",
                { fg = colors.gold }
            )
            vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = colors.foam })
            vim.api.nvim_set_hl(
                0,
                "RainbowDelimiterGreen",
                { fg = colors.pine }
            )
            vim.api.nvim_set_hl(
                0,
                "RainbowDelimiterViolet",
                { fg = colors.iris }
            )
            vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = colors.foam })
            vim.api.nvim_set_hl(
                0,
                "RainbowDelimiterOrange",
                { fg = colors.gold }
            )

            -- Custom LuaLine statuses
            local cwd = function()
                local folders = vim.lsp.buf.list_workspace_folders()
                local name = folders[1] or vim.fn.getcwd()
                if not name then
                    return
                end
                local dirname = vim.fs.dirname(name)
                if not dirname then
                    return
                end
                return " "
                    .. vim.fs.basename(dirname)
                    .. "/"
                    .. vim.fs.basename(name)
            end

            -- Arrow plugin status
            local arrowstatus = function()
                return require("arrow.statusline").text_for_statusline_with_icons()
            end

            -- Status of the LSP
            local lsp_status = function()
                local clients = vim.lsp.get_active_clients({ bufnr = 0 })
                if next(clients) == nil then
                    return ""
                end
                local initialized = {}
                for _, client in ipairs(clients) do
                    if client.initialized == true then
                        table.insert(initialized, client)
                    end
                end
                if #clients == #initialized then
                    return ""
                else
                    return ""
                end
            end

            -- Custom mode display
            local custom_mode = function()
                return string.upper(vim.api.nvim_get_mode()["mode"])
            end

            local statusline = {
                lualine_a = {
                    {
                        custom_mode,
                        separator = { left = "┃" },
                        right_padding = 2,
                    },
                },
                lualine_b = {
                    cwd,
                    "filename",
                    "branch",
                    arrowstatus,
                },
                lualine_c = { "diagnostics" },
                lualine_x = {},
                lualine_y = {
                    "filetype",
                },
                lualine_z = {
                    {
                        lsp_status,
                        separator = { right = "┃" },
                        left_padding = 2,
                        icon = "lsp",
                    },
                },
            }

            -- Lualine
            require("lualine").setup({
                options = {
                    theme = "rose-pine",
                    component_separators = "│",
                    section_separators = { left = "┃", right = "┃" },
                    globalstatus = false,
                },
                sections = statusline,
                inactive_sections = vim.tbl_extend("force", statusline, {
                    lualine_a = {},
                }),
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            })
        end,
    },
}

return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "rose-pine/neovim",
        },
        config = function()
            local lualine = require("lualine")
            -- Turn off built in showmode
            vim.opt.showmode = false

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

            -- Custom macro display
            local function show_macro_recording()
                local recording_register = vim.fn.reg_recording()
                if recording_register == "" then
                    return ""
                else
                    return "  @" .. recording_register
                end
            end

            vim.api.nvim_create_autocmd("RecordingEnter", {
                callback = function()
                    lualine.refresh({
                        place = { "statusline" },
                    })
                end,
            })

            vim.api.nvim_create_autocmd("RecordingLeave", {
                callback = function()
                    -- This is going to seem really weird!
                    -- Instead of just calling refresh we need to wait a moment because of the nature of
                    -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
                    -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
                    -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
                    -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
                    local timer = vim.loop.new_timer()
                    timer:start(
                        50,
                        0,
                        vim.schedule_wrap(function()
                            lualine.refresh({
                                place = { "statusline" },
                            })
                        end)
                    )
                end,
            })

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
                    show_macro_recording,
                },
                lualine_c = { "diagnostics" },
                lualine_x = { { "overseer" } },
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
            lualine.setup({
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
                extensions = {
                    "quickfix",
                    "lazy",
                    "oil",
                    "trouble",
                    "man",
                },
            })
        end,
    },
}

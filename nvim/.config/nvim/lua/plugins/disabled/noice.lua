return {
    "folke/noice.nvim",
    lazy = false,
    keys = {
        {
            "<leader>nl",
            function()
                require("noice").cmd("last")
            end,
            desc = "Last Notification",
        },
        {
            "<leader>nh",
            function()
                require("noice").cmd("history")
            end,
            desc = "Notification History",
        },
    },
    config = function()
        require("noice").setup({
            cmdline = {
                view = "cmdline",
                format = {
                    cmdline = { icon = ":" },
                },
            },
            redirect = {
                view = "mini",
            },
            commands = {
                errors = {
                    view = "mini",
                },
            },
            messages = {
                view = "mini",
                view_error = "mini",
                view_warn = "mini",
            },
            message = {
                view = "mini",
            },
            hover = {
                enabled = true,
            },
            lsp = {
                view = "mini",
            },
            notify = {
                view = "mini",
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                lsp_doc_border = true,
            },
            views = {
                popupmenu = {
                    relative = "editor",
                    position = {
                        row = 8,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = 10,
                    },
                    border = {
                        style = "rounded",
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = {
                            Normal = "Normal",
                            FloatBorder = "DiagnosticInfo",
                        },
                    },
                },
            },
        })
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
}

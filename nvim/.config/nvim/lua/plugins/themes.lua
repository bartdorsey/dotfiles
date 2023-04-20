-- Theme
return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin")
            require("catppuccin").setup({
                integrations = {
                    lsp_trouble = true,
                    markdown = true,
                    dap = {
                        enabled = true,
                        enable_ui = true,
                    },
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = { "italic" },
                            hints = { "italic" },
                            warnings = { "italic" },
                            information = { "italic" },
                        },
                        underlines = {
                            errors = { "underline" },
                            hints = { "underline" },
                            warnings = { "underline" },
                            information = { "underline" },
                        },
                    },
                    harpoon = true,
                    neotree = true,
                    gitsigns = true,
                    ts_rainbow2 = true,
                    which_key = true,
                    notify = true,
                    noice = true,
                },
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            local cwd = function()
                local folders = vim.lsp.buf.list_workspace_folders()
                local name = folders[1] or vim.fn.getcwd()
                return "  "
                    .. vim.fs.basename(vim.fs.dirname(name))
                    .. "/"
                    .. vim.fs.basename(name)
            end
            require("lualine").setup({
                options = {
                    theme = "catppuccin",
                    component_separators = "|",
                    section_separators = { left = "", right = "" },
                    globalstatus = true,
                },
                sections = {
                    lualine_a = {
                        {
                            "mode",
                            separator = { left = "" },
                            right_padding = 2,
                        },
                    },
                    lualine_b = {
                        cwd,
                        "filename",
                        "branch",
                    },
                    lualine_c = { "diagnostics" },
                    lualine_x = {},
                    lualine_y = {
                        "filetype",
                        "encoding",
                        "progress",
                    },
                    lualine_z = {
                        {
                            "location",
                            separator = { right = "" },
                            left_padding = 2,
                        },
                    },
                },
                inactive_sections = {
                    lualine_a = { "filename" },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = { "location" },
                },
                tabline = {},
                extensions = {},
            })
        end,
    },
}

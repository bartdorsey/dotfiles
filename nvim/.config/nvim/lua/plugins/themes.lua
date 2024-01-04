-- Theme
return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "RRethy/nvim-base16",
        },
        config = function()
            require("base16-colorscheme").with_config({
                telescope_borders = true,
            })

            vim.cmd("colorscheme base16-rose-pine")

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
                    theme = "base16",
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
                        {
                            function()
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
                            end,
                            icon = "lsp",
                        },
                        "filetype",
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

-- Custom LuaLine statuses

-- Current working directory
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
    return " " .. vim.fs.basename(dirname) .. "/" .. vim.fs.basename(name)
end

-- Status of the LSP
local lsp_status = function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
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

local inlay_hint_status = function()
    if vim.lsp.inlay_hint.is_enabled() then
        return "ih"
    else
        return ""
    end
end

-- Sections

local mode = {
    { "mode", icon = " " },
}

local fileinfo = {
    cwd,
    {
        "filetype",
        icon_only = true,
        icon = { align = "right" },
        separator = { right = "" },
        padding = { left = 1, right = 0 },
    },
    {
        "filename",
        padding = { left = 0, right = 1 },
        file_status = true,
        path = 4,
        shorting_target = 10,
        symbols = {
            modified = "󰝒 ",
            readonly = "󰈡 ",
            unnamed = "󱀺 ",
        },
    },
    {
        "branch",
    },
}

local diagnostics = { { "diagnostics" } }
local overseer = { { "overseer" } }
local filetype = {
    { "filetype" },
    { "encoding" },
    {
        "fileformat",
        symbols = {
            unix = "LF",
            dos = "CRLF",
            mac = "CR",
        },
    },
}

local lsp = {
    inlay_hint_status,
    {
        lsp_status,
        separator = { right = "┃" },
        left_padding = 0,
        icon = "lsp",
    },
}

-- Plugin config
return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "catppuccin/nvim",
            "AndreM222/copilot-lualine",
        },
        init = function()
            -- Turn off built in showmode
            vim.opt.showmode = false
        end,
        opts = {
            options = {
                theme = "catppuccin",
                component_separators = "│",
                section_separators = { left = "┃", right = "┃" },
                globalstatus = false,
            },
            sections = {
                lualine_a = mode,
                lualine_b = fileinfo,
                lualine_c = diagnostics,
                lualine_x = overseer,
                lualine_y = filetype,
                lualine_z = lsp,
            },
            inactive_sections = {
                lualine_a = fileinfo,
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {
                "quickfix",
                "lazy",
                "oil",
                "trouble",
                "man",
                "man",
                "mason",
                "overseer",
            },
        },
    },
}

_G.dd = function(...)
    require("snacks.debug").inspect(...)
end
_G.bt = function(...)
    require("snacks.debug").backtrace()
end
_G.p = function(...)
    require("snacks.debug").profile(...)
end
vim.print = _G.dd

local which = require("util").which

-- this hacks vim.ui.open to support wsl-open
local default_vim_ui_open = vim.ui.open

---@diagnostic disable-next-line: duplicate-set-field
vim.ui.open = function(url)
    if which("wsl-open") then
        return vim.fn.system("wsl-open " .. url)
    else
        return default_vim_ui_open(url)
    end
end

-- global options
require("config.options")

-- global keymaps
require("config.keymaps")

-- global commands
require("config.commands")

-- global autocmds
require("config.autocmds")

-- quickfix
require("config.quickfix")

-- Lazy
require("config.lazy")

-- Neovide specific settings
if vim.g.neovide then
    vim.o.guifont = "AtkynsonMono Nerd Font:h12"
    vim.g.neovide_opacity = 0.8
    vim.g.transparency = 0.8
    vim.g.neovide_normal_opacity = 0.8
    -- vim.g.neovide_window_blurred = true
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_refresh_rate = 120
    vim.g.neovide_cursor_vfx_mode = "sonicboom"
end

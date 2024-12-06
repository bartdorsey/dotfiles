local which = require("util").which

-- this hacks vim.ui.open to support wsl-open
local default_vim_ui_open = vim.ui.open

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

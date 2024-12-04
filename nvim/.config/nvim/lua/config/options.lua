-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- vim.g.netrw_liststyle = 3

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set the terminal title
vim.cmd("set title")

-- 256 colors
vim.opt.termguicolors = true
-- Swap and undo
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.o.undofile = true

-- set the characters used for indentations
vim.opt.list = true
vim.opt.listchars = {
    tab = "».",
    extends = "›",
    precedes = "‹",
    nbsp = "·",
    trail = "·",
}

-- Folding with nvim-treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldenable = true

-- Split Behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Neovide
if vim.g.neovide then
    vim.o.guifont = "Monaspace Argon"
    vim.g.neovide_refresh_rate = 170
    vim.g.neovide_refresh_rate_idle = 60
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_confirm_quit = false
    vim.g.neovide_floating_opacity = 1.0
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_cursor_animate_command_line = true
    vim.g.neovide_cursor_trail_size = 0.1
    vim.g.neovide_cursor_animation_length = 0.1
    vim.g.neovide_scroll_animation_length = 0.1
    vim.g.neovide_cursor_vfx_mode = "ripple"
    vim.cmd("cd ~")
end

-- Setup OSC52 for clipboard
vim.g.clipboard = {
    name = "OSC 52",
    copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
        ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
        ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
}

return {}

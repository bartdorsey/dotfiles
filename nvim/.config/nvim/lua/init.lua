-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- vim.g.netrw_liststyle = 3

-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd("set title")

vim.opt.termguicolors = true
-- Plugins
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    defaults = {
        cond = vim.g.vscode == nil,
    },
    spec = {
        { import = "plugins" },
    },
    ui = {},
    checker = {
        enabled = true,
        notify = true,
    },
    change_detection = {
        enabled = true,
        notify = true,
    },
    install = {
        missing = true,
        colorscheme = { "dawn" },
    },
})

-- Post plugin configurations
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

-- Swap and undo
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.o.undofile = true

vim.opt.list = true
vim.opt.listchars = {
    tab = "».",
    extends = "›",
    precedes = "‹",
    nbsp = "·",
    trail = "·",
}

-- Concealing (for Obsidian plugin)
-- vim.opt.conceallevel = 1

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldenable = true

-- local in_wsl = os.getenv("WSL_DISTRO_NAME") ~= nil

-- Split
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Resizing windows
vim.keymap.set(
    "n",
    "<A-l>",
    "<cmd>vertical resize -4<CR>",
    { desc = "Make vertical split smaller" }
)
vim.keymap.set(
    "n",
    "<A-h>",
    "<cmd>vertical resize +4<CR>",
    { desc = "Make vertical split larger" }
)
vim.keymap.set(
    "n",
    "<A-k>",
    "<cmd>resize -2<CR>",
    { desc = "Make horizontal split smaller" }
)
vim.keymap.set(
    "n",
    "<A-j>",
    "<cmd>resize +2<CR>",
    { desc = "Make horizontal split larger" }
)
-- Window movement
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to window right" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to window left" })

-- Let you move visual blocks with J and K
vim.keymap.set(
    "v",
    "J",
    ":m '>+1<cr>gv=gv",
    { desc = "Move selected lines up" }
) -- up
vim.keymap.set(
    "v",
    "K",
    ":m '<-2<cr>gv=gv",
    { desc = "move selected lines down" }
) -- down

-- Easier reach to beginning and end of lines
vim.keymap.set(
    "n",
    "H",
    "^",
    { desc = "Move to beginning of text on current line" }
)
vim.keymap.set("n", "L", "g_", { desc = "Move to end of text on current line" })
vim.keymap.set(
    "v",
    "L",
    "g_",
    { desc = "Move to end of text on current line - Visual mode" }
)

-- remap escape to a closer key
vim.keymap.set(
    "i",
    "jj",
    "<Esc>",
    { desc = "Remap escape to 'j' key twice for ergonomics - Insert mod" }
)

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Paste over without losing what's in your clipboard
vim.keymap.set("x", "<leader>P", '"_dP')

-- Yank into system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Paste from system clipboard
-- vim.keymap.set("n", "<leader>p", '"+p"')
-- vim.keymap.set("v", "<leader>p", '"+p"')

-- Captial Q is the worst place in the universe
vim.keymap.set("n", "Q", "<nop>")

-- q: is too close to :q for my tastes, and I never use it.
vim.keymap.set("n", "q:", "<nop>")

-- Control-S save
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group =
    vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

-- When closing the last window, load alpha back up
vim.api.nvim_create_user_command("Q", function()
    local multiple_windows, _ =
        pcall(vim.api.nvim_win_close, vim.fn.win_getid(), false)

    if multiple_windows then
        vim.cmd.bd()
    elseif vim.o.ft == "alpha" then
        vim.cmd.quitall()
    else
        vim.cmd.bd()
        vim.cmd.Alpha()
    end
end, {})

-- GuiCursor

vim.opt.guicursor = "n-v-c-sm:block-blinkon1,i-ci-ve:ver20,r-cr-o:hor20"

-- Configure vim short messages
vim.o.shortmess = "ltToOCIFa"

-- Toggle relative numbers based on mode
vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
        vim.opt.relativenumber = false
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        vim.opt.relativenumber = true
    end,
})
-- sets working dir to neovim config and opens telescope
vim.api.nvim_create_user_command("Config", function()
    vim.cmd("cd ~/.dotfiles/nvim/.config/nvim")
    vim.cmd("edit lua/init.lua")
end, {})

-- sets working dir to plugins dir and opens Oil
vim.api.nvim_create_user_command("Plugins", function()
    vim.cmd("cd ~/.dotfiles/nvim/.config/nvim")
    vim.cmd("Oil ~/.dotfiles/nvim/.config/nvim/lua/plugins")
end, {})

-- Better terminal defaults
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.cmd.startinsert()
    end,
})

require("quickfix")

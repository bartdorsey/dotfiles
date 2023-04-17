-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- vim.g.netrw_liststyle = 3

-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true
-- Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

local opts = {
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        enabled = false,
    },
}

require("lazy").setup("plugins", opts)

-- Post plugin configurations
if vim.g.neovide then
    vim.o.guifont = "Iosevka NF"
    vim.g.neovide_background_color = "#1e1e2e"
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_refresh_rate_idle = 60
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_confirm_quit = false
    vim.g.neovide_floating_opacity = 1.0
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_cursor_animate_command_line = false
end

-- [[ Setting options ]]

-- Make line numbers default
vim.wo.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Swap and undo
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect,preview"

-- Indenting
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.list = true
vim.opt.listchars = {
    tab = "».",
    extends = "›",
    precedes = "‹",
    nbsp = "·",
    trail = "·",
}

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldenable = true

-- Search Highlighting
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Scrolling
vim.opt.scrolloff = 1000
-- Turn on column for icons all the time
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

local in_wsl = os.getenv("WSL_DISTRO_NAME") ~= nil

if in_wsl then
    vim.g.clipboard = {
        name = "wsl clipboard",
        copy = { ["+"] = { "clip.exe" }, ["*"] = { "clip.exe" } },
        paste = { ["+"] = { "nvim_paste" }, ["*"] = { "nvim_paste" } },
        cache_enabled = true,
    }
end

-- Split
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.api.nvim_set_keymap(
    "n",
    "<Leader>mp",
    ":MarkdownPreview<CR>",
    { silent = true }
)

-- Let you move visual blocks with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Cursor in middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste over without losing what's in your clipboard
vim.keymap.set("x", "<leader>P", '"_dP')

-- Yank into system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Paste from system clipboard
vim.keymap.set("n", "<leader>p", '"+p"')
vim.keymap.set("v", "<leader>p", '"+p"')

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

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
end

-- [[ Setting options ]]

-- Make line numbers default
vim.wo.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
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
-- Search Highlighting
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Scrolling
vim.opt.scrolloff = 8
-- Turn on column for icons all the time
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

-- Clipboard
vim.opt.clipboard = "unnamedplus"

local in_wsl = os.getenv("WSL_DISTRO_NAME") ~= nil

if in_wsl then
    vim.g.clipboard = {
        name = "wsl clipboard",
        copy = { ["+"] = { "clip.exe" },["*"] = { "clip.exe" } },
        paste = { ["+"] = { "nvim_paste" },["*"] = { "nvim_paste" } },
        cache_enabled = true,
    }
end

-- Split
vim.opt.splitbelow = true
vim.opt.splitright = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap for Ex
-- vim.keymap.set("n", "<leader>ex", vim.cmd.Ex, { desc = "Ex mode" })

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

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
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
-- vim.keymap.set("x", "<leader>p", "\"_dP")

-- Yank into system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Captial Q is the worst place in the universe
vim.keymap.set("n", "Q", "<nop>")

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

-- local function get_focusable_windows()
--     local focusable_windows = {}
--     local windows = vim.api.nvim_list_wins()
--     for _, win in ipairs(windows) do
--         local wininfo = vim.api.nvim_win_get_config(win)
--         if wininfo.relative == '' then
--             table.insert(focusable_windows, win)
--         end
--     end
--     return focusable_windows
-- end
--
-- vim.api.nvim_create_user_command('Windows', function()
--     vim.pretty_print(get_focusable_windows())
-- end, { desc = "Get Windows"} )
--
-- vim.api.nvim_create_user_command("Q", function()
--     local windows = get_focusable_windows()
--     vim.pretty_print(windows)
--     if #windows >= 2 then
--         vim.cmd.quit()
--         return
--     end
--     local filetype = vim.bo.filetype
--     if filetype ~= "alpha" then
--         vim.cmd.bd()
--         vim.cmd.Alpha()
--         return
--     end
--     vim.cmd.quit()
-- end, {desc = "Smart close." })
--
-- vim.cmd.cnoreabbrev("<expr>", "q", "'Q'")
--
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
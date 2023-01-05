vim.api.nvim_set_keymap('n', '<Leader>mp', ':MarkdownPreview<CR>', { silent = true })

-- Let you move visual blocks with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Cursor in middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Yank into system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Captial Q is the worst place in the universe
vim.keymap.set("n", "Q", "<nop>")

-- Control-S save
vim.keymap.set({"n", "i", "v"}, "<C-s>", "<cmd>w<CR>")


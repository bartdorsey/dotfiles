local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local telescope = require('telescope.builtin')

map("n", "<leader>pv", "<cmd>Ex<CR>", opts)

map("n", "<leader>ff", "", { callback = telescope.find_files, noremap = true, silent = true })
map("n", "<leader>fg", "", { callback = telescope.live_grep, noremap = true, silent = true })
map("n", "<leader>fb", "", { callback = telescope.buffers, noremap = true, silent = true })
map("n", "<leader>fh", "", { callback = telescope.help_tags, noremap = true, silent = true })

map("n", "<C-n>", "<cmd>NERDTreeToggle<CR>", opts)

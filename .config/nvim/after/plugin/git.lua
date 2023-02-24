-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- LazyGit
vim.keymap.set('n', '<leader>lg', ':LazyGit<CR>', { desc = '[l]azy[g]it' })

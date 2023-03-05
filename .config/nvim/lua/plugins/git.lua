return {
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  { 'lewis6991/gitsigns.nvim',
    config = function()
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
    end
  },
  -- lazygit.nvim
  { 'kdheepak/lazygit.nvim',
    config = function()
      vim.keymap.set('n', '<leader>lg', ':LazyGit<CR>', { desc = '[l]azy[g]it' })
    end
  },
}

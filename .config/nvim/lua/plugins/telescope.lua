return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        defaults = {
          file_ignore_patterns = { "^.git/" },
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          }
        }
      }

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'file_browser')

      -- See `:help telescope.builtin`
      vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer]' })

      vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[s]earch [f]iles' })
      vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[s]earch [h]elp' })
      vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[s]earch current [w]ord' })
      vim.keymap.set('n', '<leader>sr', require('telescope.builtin').live_grep, { desc = '[s]earch by [g]rep' })
      vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[s]earch [d]iagnostics' })
      vim.keymap.set("n", "<leader>cp", require('telescope.builtin').commands, { desc = "[c]ommand [p]allet" })
      vim.keymap.set("n", "<leader>sg", require('telescope.builtin').git_files, { desc = "Search [g]it [f]iles" })
      vim.keymap.set("n", "<leader>sk", require('telescope.builtin').keymaps, { desc = "[s]earch [k]eymaps" })
      vim.keymap.set("n", "<leader>fb", require('telescope').extensions.file_browser.file_browser,
        { desc = "[f]ile [b]rowser" })
    end
  },
  {
    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    {
      'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1
    },
  }
}
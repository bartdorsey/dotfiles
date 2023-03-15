local function fuzzily_search()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end

local function open_file_browser()
    require('telescope').extensions.file_browser.file_browser()
end


return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            { '<leader>?',       '<cmd>Telescope oldfiles<cr>',    desc = '[?] Find recently opened files' },
            { '<leader><space>', '<cmd>Telescope buffers<cr>',     desc = '[ ] Find existing buffers' },
            { '<leader>sf',      '<cmd>Telescope find_files<cr>',  desc = '[s]earch [f]iles' },
            { '<leader>/',       fuzzily_search,              desc = '[/] Fuzzily search in current buffer' },
            { '<leader>sh',      '<cmd>Telescope help_tags<cr>',   desc = '[s]earch [h]elp' },
            { '<leader>sw',      '<cmd>Telescope grep_string<cr>', desc = '[s]earch current [w]ord' },
            { '<leader>sr',      '<cmd>Telescope live_grep<cr>',   desc = '[s]earch by [g]rep' },
            { '<leader>sd',      '<cmd>Telescope diagnostics<cr>', desc = '[s]earch [d]iagnostics' },
            { '<leader>cp',      '<cmd>Telescope commands<cr>',    desc = '[c]ommand [p]allete' },
            { '<leader>gf',      '<cmd>Telescope git_files<cr>',   desc = 'search [g]it [f]iles' },
            { '<leader>sk',      '<cmd>Telescope keymaps<cr>',     desc = '[s]earch [k]eymaps' },
            { '<leader>fb',      open_file_browser,           desc = '[f]ile [b]rowser' }
        },
        config = function()
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

            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'file_browser')
        end
    },
    {
        -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
        {
            'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1
        },
    }
}

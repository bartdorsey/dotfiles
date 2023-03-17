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
            { '<leader>?',       '<cmd>Telescope oldfiles<cr>',    desc = 'Find recently opened files' },
            { '<leader><space>', '<cmd>Telescope buffers<cr>',     desc = 'Find existing buffers' },
            { '<leader>sf',      '<cmd>Telescope find_files<cr>',  desc = 'Search Files' },
            { '<leader>se',      '<cmd>Telescope emoji<cr>',       desc = 'Search Emoji' },
            { '<leader>snf',     '<cmd>Telescope glyph<cr>',       desc = 'Search Nerd Font Glyphs' },
            { '<leader>/',       fuzzily_search,                   desc = '[/] Fuzzily search in current buffer' },
            { '<leader>sh',      '<cmd>Telescope help_tags<cr>',   desc = 'Search Help' },
            { '<leader>sw',      '<cmd>Telescope grep_string<cr>', desc = 'Search Current Word' },
            { '<leader>sr',      '<cmd>Telescope live_grep<cr>',   desc = 'Search by Grep' },
            { '<leader>sd',      '<cmd>Telescope diagnostics<cr>', desc = 'Search Diagnostics' },
            { '<leader>cp',      '<cmd>Telescope commands<cr>',    desc = 'Command Pallete' },
            { '<leader>gf',      '<cmd>Telescope git_files<cr>',   desc = 'Search Git Files' },
            { '<leader>sk',      '<cmd>Telescope keymaps<cr>',     desc = 'Search Keymaps' },
            { '<leader>fb',      open_file_browser,                desc = 'File Browser' }
        },
        config = function()
            local actions = require('telescope.actions')
            require('telescope').setup {
                defaults = {
                    file_ignore_patterns = { "^.git/" },
                    mappings = {
                        i = {
                            ['<C-u>'] = false,
                            ['<C-d>'] = false,
                            ['<esc>'] = actions.close
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
            pcall(require('telescope').load_extension, 'glyph')
            pcall(require('telescope').load_extension, 'emoji')
            pcall(require('telescope').load_extension, 'cheatsheet')
        end
    },
    {
        -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
        {
            'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1
        },
        { 'ghassan0/telescope-glyph.nvim' },
        { 'xiyaowong/telescope-emoji.nvim' },
        {
            'sudormrfbin/cheatsheet.nvim',
            dependencies = { 'nvim-lua/popup.nvim', }
        },
        { 'nvim-telescope/telescope-file-browser.nvim' },
    }
}

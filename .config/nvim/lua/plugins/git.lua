return {
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    {
        'lewis6991/gitsigns.nvim',
        config = function()
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
    {
        'kdheepak/lazygit.nvim',
        keys = {
            { '<leader>lg', '<cmd>LazyGit<cr>', desc = '[l]azy [g]it' }
        }
    },
}

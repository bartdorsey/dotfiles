return {
    {
        'tpope/vim-fugitive',
        event = "BufReadPre"
    },
    {
        'lewis6991/gitsigns.nvim',
        event = "BufReadPre",
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
        cmd = { 'LazyGit '},
        keys = {
            { '<leader>lg', '<cmd>LazyGit<cr>', desc = '[l]azy [g]it' }
        }
    },
}

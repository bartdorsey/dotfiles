return {
    'folke/trouble.nvim',
    cmd = {'Trouble', 'TroubleToggle'},
    keys = {
        { '<leader>xx', '<cmd>TroubleToggle<cr>', desc = "Trouble Toggle"}
    },
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    config = function ()
        require('trouble').setup()
    end
}

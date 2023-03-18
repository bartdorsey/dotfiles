return {
    'echasnovski/mini.comment',
    version = '*',
    event = "BufReadPre",
    config = function()
        require('mini.comment').setup()
    end
}

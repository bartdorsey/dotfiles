return {
    'rcarriga/nvim-notify',
    config = function()
        require('notify').setup({
            background_colour = '#000000',
            timeout = 10
        })
        require('telescope').load_extension('notify')
    end
}

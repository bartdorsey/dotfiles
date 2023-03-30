return {
    'NvChad/nvim-colorizer.lua',
    ft = {'css', 'scss', 'less', 'html', 'jsx', 'tsx'},
    config = function()
        require('colorizer').setup()
    end
}

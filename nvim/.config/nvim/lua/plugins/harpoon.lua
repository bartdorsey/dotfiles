return {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        {
            '<leader>ha',
            function()
                require('harpoon.mark').add_file()
                require('notify')('harpooned file')
            end,
            desc = 'Harpoon Add'
        },
        {
            '<leader>hl',
            function()
                require('harpoon.ui').toggle_quick_menu()
            end,
            desc = 'Harpoon List'
        },
        {
            '<leader>hn',
            function()
                require('harpoon.ui').nav_next()
            end,
            desc = 'Harpoon Next'
        },
        {
            '<leader>hp',
            function()
                require('harpoon.ui').nav_prev()
            end,
            desc = 'Harpoon Previous'
        },
        {
            '<leader>h1',
            function()
                require('harpoon.ui').nav_file(1)
            end,
            desc = 'Harpoon 1'
        },
        {
            '<leader>h2',
            function()
                require('harpoon.ui').nav_file(2)
            end,
            desc = 'Harpoon 2'
        },
        {
            '<leader>h3',
            function()
                require('harpoon.ui').nav_file(3)
            end,
            desc = 'Harpoon 3'
        },
        {
            '<leader>h4',
            function()
                require('harpoon.ui').nav_file(4)
            end,
            desc = 'Harpoon 4'
        },
    },
    config = function()
        require('harpoon').setup()
        require('telescope').load_extension('harpoon')
    end
}

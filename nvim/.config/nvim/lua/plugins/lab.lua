return {
   '0x100101/lab.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    config = function ()
        require('lab').setup({
            code_runner = {
                enabled = true,
            },
            quick_data = {
                enabled = true
            }
        })
    end
}

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
return {
    'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
    event = "BufReadPre",
    config = function()
        require('ibl').setup({
            indent = { char = '┊' },
            whitespace = {
                remove_blankline_trail = false
            },
            scope = {
                enabled = true,
                show_exact_scope = true
            }
        })
    end
}

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
return {
  'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
  config = function()
    require('indent_blankline').setup {
      char = '┊',
      show_trailing_blankline_indent = false
    }
  end
}

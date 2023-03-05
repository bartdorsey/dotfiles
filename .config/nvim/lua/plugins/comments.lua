return {
  'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines
  config = function()
    -- Enable Comment.nvim
    require('Comment').setup()
  end
}

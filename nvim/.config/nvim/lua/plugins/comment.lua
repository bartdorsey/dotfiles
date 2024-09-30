return {
    cond = true,
    'numToStr/Comment.nvim',
    lazy = false,
    config = function()
        require('Comment').setup({
            mappings = {
                basic = true,
                extra = false
            }
        })
    end
}

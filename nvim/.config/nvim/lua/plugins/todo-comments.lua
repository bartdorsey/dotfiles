return {
    'folke/todo-comments.nvim',
    dependencies = { "nvim-lua/plenary.nvim"},
    cmd = {"TodoTrouble", "TodoTelescope"},
    config = function()
        require('todo-comments').setup()
    end
}

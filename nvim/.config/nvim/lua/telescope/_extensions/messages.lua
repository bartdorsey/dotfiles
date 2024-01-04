return require("telescope").register_extension({
    setup = function()
    end,
    exports = {
        messages = function()
            local msg = vim.cmd("redir => g:messages | silent! messages | redir END")
            local lines = vim.split(vim.g.messages, "\n")
            require('telescope.pickers').new({}, {
                prompt_title = 'Messages',
                finder = require('telescope.finders').new_table({
                    results = lines,
                }),
            }):find()
        end
    }
})

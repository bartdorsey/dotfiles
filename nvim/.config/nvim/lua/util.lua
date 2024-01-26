return {
    which = function(program)
        if vim.fn.executable(program) == 1 then
            return true
        else
            return false
        end
    end,
}

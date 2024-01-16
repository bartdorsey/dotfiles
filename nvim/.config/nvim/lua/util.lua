return {
    which = function(program)
        local handle = io.popen("which " .. program .. " 2> /dev/null")
        local result = handle:read("*a")
        handle:close()

        return result ~= ""
    end,
}

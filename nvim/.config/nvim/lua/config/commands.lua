-- When closing the last window, load alpha back up
vim.api.nvim_create_user_command("Q", function()
    local multiple_windows, _ =
        pcall(vim.api.nvim_win_close, vim.fn.win_getid(), false)

    if multiple_windows then
        vim.cmd.bd()
    elseif vim.o.ft == "alpha" then
        vim.cmd.quitall()
    else
        vim.cmd.bd()
        vim.cmd.Alpha()
    end
end, {})

-- sets working dir to neovim config and opens telescope
vim.api.nvim_create_user_command("Config", function()
    vim.cmd("cd ~/.dotfiles/nvim/.config/nvim")
    vim.cmd("edit lua/init.lua")
end, {})

-- sets working dir to plugins dir and opens Oil
vim.api.nvim_create_user_command("Plugins", function()
    vim.cmd("cd ~/.dotfiles/nvim/.config/nvim")
    vim.cmd("Oil ~/.dotfiles/nvim/.config/nvim/lua/plugins")
end, {})

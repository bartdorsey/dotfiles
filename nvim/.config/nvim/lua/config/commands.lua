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

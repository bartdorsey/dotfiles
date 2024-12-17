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

vim.api.nvim_create_user_command("UUID", function()
    -- Run `uuidgen` and capture the output
    local handle = io.popen("uuidgen")
    local result = handle:read("*a") -- Read the entire output
    handle:close()

    -- Strip out the newline character
    local uuid = result:gsub("%s+", "")

    -- Insert the UUID at the current cursor position
    vim.api.nvim_put({ uuid }, "", true, true)
end, {})

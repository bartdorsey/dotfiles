-- sets working dir to neovim config and opens telescope
vim.api.nvim_create_user_command("Config", function()
    vim.cmd("cd ~/.dotfiles/nvim/.config/nvim")
    vim.cmd("edit lua/init.lua")
end, {})

-- sets working dir to plugins dir and opens Oil
vim.api.nvim_create_user_command("ConfigDir", function()
    vim.cmd("cd ~/.dotfiles/nvim/.config/nvim")
    vim.cmd("Oil ~/.dotfiles/nvim/.config/nvim/")
end, {})

-- sets working dir to Dotfiles repo
vim.api.nvim_create_user_command("Dotfiles", function()
    vim.cmd("cd ~/.dotfiles/")
    vim.cmd("Oil ~/.dotfiles/")
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

vim.api.nvim_create_user_command("GitWebURL", function()
    local filename = vim.fn.expand("%") -- Get the current buffer's filename
    local output = vim.fn.system("git-web-url " .. filename) -- Run the shell script with the filename
    vim.fn.setreg("+", output) -- Yank the output to the clipboard register
end, { nargs = 0 })

-- Mini Sessions commands
vim.api.nvim_create_user_command("SSave", function(opts)
    MiniSessions.write(opts.fargs[1])
end, { nargs = 1 })

vim.api.nvim_create_user_command("SLoad", function()
    MiniSessions.read(MiniSessions.get_latest())
end, { nargs = 0 })

vim.api.nvim_create_user_command("SDelete", function()
    MiniSessions.delete(nil, { force = true })
end, { nargs = 0 })

vim.api.nvim_create_user_command("Glow", function()
    local file = vim.fn.expand("%:p") -- Get the absolute path of the current file
    if file ~= "" then
        vim.cmd("vsplit | terminal glow -p " .. vim.fn.shellescape(file))
    else
        print("No file to preview with glow")
    end
end, {})

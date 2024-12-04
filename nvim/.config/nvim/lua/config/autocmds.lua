-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group =
    vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

-- Toggle relative numbers based on mode
vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
        vim.opt.relativenumber = false
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        vim.opt.relativenumber = true
    end,
})

-- Better terminal defaults
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.cmd.startinsert()
    end,
})

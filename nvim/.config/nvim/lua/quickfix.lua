-- quickfix diagnostics
vim.api.nvim_create_autocmd({ "DiagnosticChanged" }, {
    callback = function()
        vim.diagnostic.setloclist({ open = false })
    end,
})

-- shortcut to open quickfix list
vim.keymap.set("n", "<leader>co", function()
    vim.api.nvim_command("copen")
end, { desc = "Open quickfix list" })

vim.keymap.set("n", "<leader>cn", "<cmd>cnext<cr>")
vim.keymap.set("n", "<leader>cp", "<cmd>cprev<cr>")

-- shortcut to open quickfix list
vim.keymap.set("n", "<leader>lo", function()
    vim.diagnostic.setloclist()
    vim.api.nvim_command("lopen")
end, { desc = "Open quickfix list" })

vim.keymap.set("n", "<leader>ln", "<cmd>lnext<cr>")
vim.keymap.set("n", "<leader>lp", "<cmd>lprev<cr>")

-- Run markdown lint against all the files
vim.api.nvim_create_user_command("MarkdownLint", function()
    vim.notify("Running markdownlint")
    local olderrorformat = vim.opt.errorformat
    vim.opt.errorformat = {
        "%f:%l:%c %m",
        "%f:%l %m",
    }
    vim.api.nvim_command(
        "cexpr systemlist('markdownlint -i node_modules **/*.md')"
    )
    vim.api.nvim_command("copen")
    vim.opt.errorformat = olderrorformat
    vim.notify("Done")
end, {})

vim.keymap.set("n", "<leader>mdl", "<cmd>MarkdownLint<cr>")

vim.api.nvim_create_user_command("TODOs", function()
    vim.notify("Searching for TODOS")
    vim.api.nvim_command("cexpr systemlist('rg --vimgrep TODO -tmd')")
    vim.notify("Done")
    vim.api.nvim_command("copen")
end, {})

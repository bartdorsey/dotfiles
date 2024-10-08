-- quickfix diagnostics
vim.api.nvim_create_autocmd({ "DiagnosticChanged" }, {
    callback = function()
        vim.diagnostic.setqflist({ open = false })
    end,
})

-- shortcut to open quickfix list
vim.keymap.set("n", "<leader>co", function()
    vim.diagnostic.setqflist()
    vim.api.nvim_command("copen")
end, { desc = "Open quickfix list" })

vim.keymap.set("n", "<leader>cn", "<cmd>cnext<cr>")
vim.keymap.set("n", "<leader>cp", "<cmd>cprev<cr>")

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


local dap = require('dap')

-- debugging
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>dso", dap.step_over)
vim.keymap.set("n", "<leader>dsi", dap.step_into)
vim.keymap.set("n", "<leader>dsu", dap.step_out)
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)

require('dapui').setup()


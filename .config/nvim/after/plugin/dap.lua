local dap = require('dap')

-- debugging keymaps
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>dso", dap.step_over)
vim.keymap.set("n", "<leader>dsi", dap.step_into)
vim.keymap.set("n", "<leader>dsu", dap.step_out)
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)

-- Rust Configuration
dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode-14', -- adjust as needed, must be absolute path
    name = 'lldb'
}

dap.configurations.rust = { {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
} };

-- Setup VSCode JS/TS Debugging
require('dap-vscode-js').setup({
    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }
})

-- configure debugging for typescript and javascript
for _, language in ipairs({ "typescript", "javascript" }) do
    dap.configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require 'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
        }
    }
end

-- DapUI Setup
local dapui = require('dapui')

dapui.setup({
    controls = {
        element = "stacks",
        enabled = true
    },
    layouts = {
        {
            elements = {
                {
                    id = "scopes",
                    size = 0.25
                },
                {
                    id = "stacks",
                    size = 0.25
                }
            },
            position = "left",
            size = 40
        }
    }
})

-- Cause dapui to automatically appear and disappear
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- DapUI keybinds
vim.keymap.set("n", "<leader>dui", dapui.toggle)

-- Setup dap virtual text
require('nvim-dap-virtual-text').setup()

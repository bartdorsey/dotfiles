return {
    -- DAP
    {
        'mfussenegger/nvim-dap',
        config = function()
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
        end
    },
    -- DAP Virtual Text
    {
        'theHamsta/nvim-dap-virtual-text',
        config = function()
            -- Setup dap virtual text
            require('nvim-dap-virtual-text').setup()
        end },
    -- Telescope DAP
    'nvim-telescope/telescope-dap.nvim',
    -- Dap VSCode
    {
        "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" }
    },
    -- VSCode JS Debugger
    {
        "microsoft/vscode-js-debug",
        lazy = true,
        build = "npm install --legacy-peer-deps && npm run compile",
        config = function()
            -- Setup VSCode JS/TS Debugging
            require('dap-vscode-js').setup({
                adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }
            })
        end
    }
}

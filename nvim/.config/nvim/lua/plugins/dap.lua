return {
    -- DAP
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            -- "mxsdev/nvim-dap-vscode-js",
            -- {
            --     "microsoft/vscode-js-debug",
            --     build = "npm install --legacy-peer-deps && npm run compile",
            --     config = function()
            --         -- Setup VSCode JS/TS Debugging
            --         require('dap-vscode-js').setup({
            --             adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }
            --         })
            --     end
            -- },
            {
                'theHamsta/nvim-dap-virtual-text',
                dependencies = {
                    'mfussenegger/nvim-dap',
                },
                config = function()
                    -- Setup dap virtual text
                    require('nvim-dap-virtual-text').setup({})
                end
            },
        },
        keys = {
            { '<leader>dc',  '<cmd>DapContinue<cr>',         desc = 'debug continue' },
            { '<leader>dso', '<cmd>DapStepOver<cr>',         desc = 'debug step over' },
            { '<leader>dsi', '<cmd>DapStepInto<cr>',         desc = 'debug step into' },
            { '<leader>dsu', '<cmd>DapStepOut<cr>',          desc = 'debug step out' },
            { '<leader>db',  '<cmd>DapToggleBreakpoint<cr>', desc = 'debug toggle breakpoint' },
        },
        config = function()
            local dap = require('dap')

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
}

return {
    -- DAP
    {
        'mfussenegger/nvim-dap',
        keys = {
            { '<leader>dc',  '<cmd>DapContinue<cr>',         desc = '[d]ebug [c]ontinue' },
            { '<leader>dso', '<cmd>DapStepOver<cr>',         desc = '[d]ebug [s]tep [o]ver' },
            { '<leader>dsi', '<cmd>DapStepInto<cr>',         desc = '[d]ebug [s]tep [i]nto' },
            { '<leader>dsu', '<cmd>DapStepOut<cr>',          desc = '[d]ebug [s]tep o[u]t' },
            { '<leader>db',  '<cmd>DapToggleBreakpoint<cr>', desc = '[d]ebug toggle [b]reakpoint' },
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
    {
        'theHamsta/nvim-dap-virtual-text',
        config = function()
            -- Setup dap virtual text
            require('nvim-dap-virtual-text').setup()
        end
    },
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

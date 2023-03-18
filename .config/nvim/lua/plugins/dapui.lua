return {
    -- DAP UI
    {
        'rcarriga/nvim-dap-ui',
        keys = {
            {
                '<leader>dbg',
                function()
                    require('dapui').toggle()
                end,
                desc = 'Debug'
            }
        },
        dependencies = {
            'mfussenegger/nvim-dap'
        },
        config = function()
            -- DapUI Setup
            local dapui = require('dapui')

            local dap = require('dap')
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
        end
    },
}

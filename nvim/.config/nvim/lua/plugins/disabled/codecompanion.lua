return {
    "olimorris/codecompanion.nvim"
    cond = os.getenv("DEVMODE") ~= nil,
    opts = {
        strategies = {
            chat = {
                adapter = "copilot",
            },
            inline = {
                adapter = "copilot",
            },
            cmd = {
                adapter = "copilot",
            },
        },
        adapters = {
            copilot = function()
                return require("codecompanion.adapters").extend("copilot", {
                    schema = {
                        model = {
                            default = "claude-3.7-sonnet",
                        },
                    },
                })
            end,
            openai = function()
                return require("codecompanion.adapters").extend("openai", {
                    env = {
                        api_key = "cmd:pass openai",
                    },
                })
            end,
            ollama = function()
                return require("codecompanion.adapters").extend("ollama", {
                    env = {
                        url = "http://10.0.0.72:11434",
                    },
                    schema = {
                        num_ctx = {
                            default = 20000,
                        },
                    },
                })
            end,
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
}

return {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
        -- Icons
        require("mini.icons").setup({})
        -- Notify
        local MiniNotify = require("mini.notify")
        MiniNotify.setup({})
        vim.notify = MiniNotify.make_notify()
        -- AI
        require("mini.ai").setup({})
        -- Pairs
        require("mini.pairs").setup({})
        -- Starter
        local starter = require("mini.starter")
        starter.setup({
            header = "",
            footer = "",
            evaluate_single = true,
            items = {
                starter.sections.builtin_actions(),
                starter.sections.recent_files(10, true),
                starter.sections.recent_files(10, false),
                -- Use this if you set up 'mini.sessions'
                starter.sections.sessions(5, true),
            },
            content_hooks = {
                starter.gen_hook.adding_bullet(),
                starter.gen_hook.indexing("section", { "Builtin actions" }),
                starter.gen_hook.padding(3, 2),
                starter.gen_hook.aligning("center", "center"),
            },
            query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_.",
        })
        -- Clues
        local miniclue = require("mini.clue")
        miniclue.setup({
            triggers = {
                -- Leader triggers
                { mode = "n", keys = "<Leader>" },
                { mode = "x", keys = "<Leader>" },

                -- Built-in completion
                { mode = "i", keys = "<C-x>" },

                -- `g` key
                { mode = "n", keys = "g" },
                { mode = "x", keys = "g" },

                -- Marks
                { mode = "n", keys = "'" },
                { mode = "n", keys = "`" },
                { mode = "x", keys = "'" },
                { mode = "x", keys = "`" },

                -- Registers
                { mode = "n", keys = '"' },
                { mode = "x", keys = '"' },
                { mode = "i", keys = "<C-r>" },
                { mode = "c", keys = "<C-r>" },

                -- Window commands
                { mode = "n", keys = "<C-w>" },

                -- `z` key
                { mode = "n", keys = "z" },
                { mode = "x", keys = "z" },
            },

            clues = {
                -- Enhance this by adding descriptions for <Leader> mapping groups
                miniclue.gen_clues.builtin_completion(),
                miniclue.gen_clues.g(),
                miniclue.gen_clues.marks(),
                miniclue.gen_clues.registers(),
                miniclue.gen_clues.windows(),
                miniclue.gen_clues.z(),
            },
            window = {
                delay = 0,
                config = {
                    anchor = "SW",
                    row = "auto",
                    col = "auto",
                    width = "auto",
                },
            },
        })
    end,
}

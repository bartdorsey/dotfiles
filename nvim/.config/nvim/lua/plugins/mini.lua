return {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
        -- Notify
        local MiniNotify = require("mini.notify")
        MiniNotify.setup({})
        vim.notify = MiniNotify.make_notify()
        -- AI
        require("mini.ai").setup({})
        -- Pairs
        require("mini.pairs").setup({})
        -- Sessions
        local MiniSessions = require("mini.sessions")
        MiniSessions.setup({
            directory = vim.fn.stdpath("data") .. "/sessions",
        })

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
        })
    end,
}

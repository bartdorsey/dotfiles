return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    cond = function()
        return vim.fn.isdirectory(vim.fn.expand("~/Obsidian")) == 1
    end,
    keys = {
        {
            "<leader>os",
            "<cmd>Obsidian search<cr>",
            desc = "Obsidian search",
        },
        {
            "<leader>ot",
            "<cmd>Obsidian tags<cr>",
            desc = "Obsidian tags",
        },
        {
            "<leader>od",
            "<cmd>Obsidian today<cr>",
            desc = "Obsidian today",
        },
        {
            "<leader>on",
            "<cmd>Obsidian new<cr>",
            desc = "Obsidian new",
        },
    },

    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",

        -- see below for full list of optional dependencies 👇
    },
    opts = {
        legacy_commands = false,
        ui = {
            enable = false,
        },
        workspaces = {
            {
                name = "Obsidian",
                path = "~/Obsidian",
            },
        },
        notes_subdir = "notes",
        daily_notes = {
            folder = "daily-notes",
        },
        templates = {
            subdir = "templates",
        },
        follow_url_func = function(url)
            vim.fn.jobstart({ "wsl-open", url })
        end,
        completion = {
            blink = true,
            -- Trigger completion at 2 chars.
            min_chars = 2,
        },
    },
}

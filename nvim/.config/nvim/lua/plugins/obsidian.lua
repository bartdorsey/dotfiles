return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    keys = {
        {
            "<leader>os",
            "<cmd>ObsidianSearch<cr>",
            desc = "Obsidian Search",
        },
        {
            "<leader>ot",
            "<cmd>ObsidianTags<cr>",
            desc = "Obsidian Tag Search",
        },
        {
            "<leader>od",
            "<cmd>ObsidianToday<cr>",
            desc = "Obsidian Daily Note",
        },
        {
            "<leader>on",
            "<cmd>ObsidianNew<cr>",
            desc = "Obsidian New Note",
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
        workspaces = {
            {
                name = "personal",
                path = "~/Obsidian/Journal",
            },
        },
        notes_subdir = "Notes",
        daily_notes = {
            folder = "Daily Notes",
        },
        templates = {
            subdir = "Templates",
        },
        follow_url_func = function(url)
            vim.fn.jobstart({ "wsl-open", url })
        end,
    },
}

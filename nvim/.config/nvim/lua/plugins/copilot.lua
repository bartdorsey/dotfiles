return {
    -- "github/copilot.vim",
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        lazy = true,
        dependencies = { "zbirenbaum/copilot.lua" },
        config = true,
    },
}

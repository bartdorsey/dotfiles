return {
    {
        "zbirenbaum/copilot.lua",
        enabled = false,
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        enabled = false,
        lazy = true,
        dependencies = { "zbirenbaum/copilot.lua" },
        config = true,
    },
}

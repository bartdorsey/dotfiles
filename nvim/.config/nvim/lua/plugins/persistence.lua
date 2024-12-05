return {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opene
    config = true,
    keys = {
        {
            "<leader>rs",
            "<cmd>lua require('persistence').load()<cr>",
            { desc = { "Restore Session" } },
        },
    },
}

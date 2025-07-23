return {
    "nvim-neotest/neotest",
    cmd = { "Neotest" },
    keys = {
        { "<leader>tt", "<cmd>Neotest run<cr>", desc = "Run Test" },
        { "<leader>tf", "<cmd>Neotest run file<cr>", desc = "Run Test File" },
        { "<leader>ts", "<cmd>Neotest summary<cr>", desc = "Test Summary" },
        { "<leader>to", "<cmd>Neotest output<cr>", desc = "Test Output" },
    },
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python"),
            },
        })
    end,
}

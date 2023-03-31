return {
    "CRAG666/code_runner.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>rr", "<cmd>RunCode<cr>", desc = "Run Code" },
        { "<leader>rf", "<cmd>RunFile<cr>", desc = "Run File" },
    },
    config = function()
        require("code_runner").setup({
            filetype = {
                python = "python3 -u",
                typescript = "ts-node",
                javascript = "node",
                rust = "cargo run",
            },
        })
    end,
}

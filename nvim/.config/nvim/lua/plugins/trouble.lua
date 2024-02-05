return {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    keys = {
        { "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Trouble Toggle" } },
        {
            "<leader>xw",
            "<cmd>TroubleToggle workspace_diagnostics<cr>",
            { desc = "Trouble Workspace Diagnostics" },
        },
        {
            "<leader>xd",
            "<cmd>TroubleToggle document_diagnostics<cr>",
            {
                desc = "Trouble Document Diagnostics",
            },
        },
        {
            "<leader>xq",
            "<cmd>TroubleToggle quickfix<cr>",
            {
                desc = "Trouble Quickfix list",
            },
        },
        {
            "<leader>xl",
            "<cmd>TroubleToggle loclist<cr>",
            {
                desc = "Trouble location list",
            },
        },
        {
            "gR",
            "<cmd>Trouble Toggle lsp_references<cr>",
            {
                desc = "Trouble LSP References",
            },
        },
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("trouble").setup()
    end,
}

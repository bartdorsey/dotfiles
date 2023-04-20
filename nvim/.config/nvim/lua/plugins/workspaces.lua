return {
    "natecraddock/workspaces.nvim",
    dependencies = {
        "natecraddock/sessions.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("workspaces").setup({
            hooks = {
                open_pre = {
                    "SessionsSave",
                    "SessionsStop",
                    "silent bufdo! w",
                    "silent %bdelete!",
                },
                open = function()
                    require("sessions").load(nil, { silent = true })
                end,
            },
        })

        require("telescope").load_extension("workspaces")

        vim.keymap.set("n", "<leader>w", "<cmd>Telescope workspaces<cr>", {
            desc = "Search Workspaces",
        })
    end,
}

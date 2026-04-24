return {
    "linux-cultist/venv-selector.nvim",
    cond = os.getenv("DEVMODE") ~= nil,
    enabled = true,
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-telescope/telescope.nvim",
    },
    cmd = { "VenvSelect" },
    opts = {
        settings = {
            options = {
                debug = true,
                notify_user_on_venv_activation = true,
            },
        },
    },
    keys = {
        { "<leader>v", "<cmd>VenvSelect<cr>" },
    },
}

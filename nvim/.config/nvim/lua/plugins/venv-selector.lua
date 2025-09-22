return {
    "linux-cultist/venv-selector.nvim",
    cond = os.getenv("DEVMODE") ~= nil,
    dependencies = {
        "neovim/nvim-lspconfig",
        {
            "nvim-telescope/telescope.nvim",
            branch = "0.1.x",
            dependencies = { "nvim-lua/plenary.nvim" },
        },
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

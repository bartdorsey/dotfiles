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
    branch = "regexp", -- This is the regexp branch, use this for the new version
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

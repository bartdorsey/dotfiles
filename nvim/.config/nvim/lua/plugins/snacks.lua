local which = require("util").which

local neovim = [[
⠀⠀⠀⢀⡴⣂⠀⠀⠀⠀⠀⠀⠀⠀⢰⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢀⡴⣏⣷⡹⣆⡀⠀⠀⠀⠀⠀⠀⢸⣯⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣴⣻⣽⣻⣼⢳⡹⣖⡄⠀⠀⠀⠀⠀⢸⣷⢿⣾⢷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠿⠿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
⣯⢷⣻⢷⣯⢳⡝⡾⣜⡆⠀⠀⠀⠀⢸⣿⡿⣯⣿⡇⠀⠀⠀⠀⠀⢀⡀⠀⣀⣤⣤⣀⠀⠀⠀⠀⠀⣀⣤⣤⣀⡀⠀⠀⠀⠀⢀⣠⣤⣤⣀⡀⠀⢠⣤⣤⠀⠀⠀⠀⢀⣤⣤⡄⣤⣤⠀⢠⣤⡄⣠⣤⣶⣤⡀⢀⣠⣴⣶⣤⣄⠀
⣿⢯⣟⣯⣿⢣⡿⣱⢯⡞⣧⠀⠀⠀⢸⣿⣿⣿⡿⡇⠀⠀⠀⠀⠀⢸⡷⠋⠁⠀⠀⠙⣷⠀⠀⣠⠟⠁⠀⠀⠀⠙⣦⠀⢀⡾⠋⠁⠀⠀⠉⠻⣆⠈⣿⣿⣇⠀⠀⠀⣼⣿⡟⠀⣿⣿⠀⢸⣿⣿⠟⠋⠛⢿⣿⣾⠟⠋⠛⢿⣿⣧
⣿⣟⣯⣿⣾⠈⢳⢯⡷⣛⣾⢳⡀⠀⢸⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⣹⡆⢠⣿⣤⣤⣤⣤⣤⣤⣼⡄⣼⠇⠀⠀⠀⠀⠀⠀⢿⡆⠘⣿⣿⡄⠀⢰⣿⡿⠁⠀⣿⣿⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿
⣿⡿⣯⣷⣿⠀⠀⠫⣽⣻⡼⣯⣟⣄⢸⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⢼⡇⠸⣧⠀⠀⠀⠀⠀⠀⠀⠀⣿⡀⠀⠀⠀⠀⠀⠀⣸⡇⠀⠹⣿⣷⢠⣿⣿⠃⠀⠀⣿⣿⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿
⣿⣿⣿⣿⣿⠀⠀⠀⠑⣯⢷⣻⢾⡽⣾⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⢺⡇⠀⢻⣄⠀⠀⠀⠀⠀⠀⠀⠸⣧⠀⠀⠀⠀⠀⢠⡿⠁⠀⠀⢻⣿⣿⣿⠇⠀⠀⠀⣿⣿⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿
⣿⣿⣿⣿⣾⠀⠀⠀⠀⠈⢿⡽⣯⢿⣽⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠸⠇⠀⠀⠀⠀⠀⠹⠇⠀⠀⠙⠳⠦⠤⠴⠞⠋⠀⠀⠈⠳⠦⠤⠤⠶⠋⠁⠀⠀⠀⠀⠿⠿⠏⠀⠀⠀⠀⠿⠿⠀⠸⠿⠿⠀⠀⠀⠸⠿⠿⠀⠀⠀⠸⠿⠿
⢿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠈⢻⣽⣻⣾⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠙⢿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠹⣷⢿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠙⢿⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]]

return {
    "folke/snacks.nvim",
    priority = 1000,
    dependencies = {
        "folke/persistence.nvim",
    },
    lazy = false,
    keys = {
        {
            "<leader>lg",
            function()
                Snacks.lazygit()
            end,
            desc = "LazyGit",
        },
        {
            "<leader>go",
            function()
                Snacks.gitbrowse()
            end,
            desc = "Open Repo in Browser",
        },
        {
            "<leader>rf",
            function()
                Snacks.rename.rename_file()
            end,
            desc = "Rename file",
        },
        {
            "<leader>gb",
            function()
                Snacks.git.blame_line()
            end,
            desc = "Blame line",
        },
        {
            "<C-Space>",
            function()
                Snacks.terminal()
            end,
            desc = "Toggle Terminal",
        },
    },
    opts = {
        bigfile = { enabled = true },
        gitbrowse = {
            enabled = true,
        },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
    },
}
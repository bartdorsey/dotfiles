return {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    cmd = "Neotree",
    branch = "v2.x",
    keys = {
        { "<leader>tt", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require('neo-tree').setup({
            window = {
                width = 45
            },
            close_if_last_window = true,
            use_libuv_file_watcher = true,
            filesystem = {
                filtered_items = {
                    visible = true
                },
                bind_to_cwd = true,
                follow_current_file = true,
                hijack_netrw_behavior = "open_default",
            },
            source_selector = {
                winbar = true,
                statusline = false
            }
        })
    end
}

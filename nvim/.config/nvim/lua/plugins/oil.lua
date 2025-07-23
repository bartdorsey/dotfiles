return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    enabled = true,
    opts = {
        buf_options = {
            buflisted = true,
            bufhidden = "",
        },
        default_file_explorer = true,
        skip_confim_for_simple_edits = true,
        lsp_file_methods = {
            autosave_changes = true,
        },
        keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-s>"] = "actions.select_vsplit",
            ["<C-h>"] = "actions.select_split",
            ["<C-t>"] = "actions.select_tab",
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["<C-l>"] = "actions.refresh",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd",
            ["g."] = "actions.toggle_hidden",
            ["<esc>"] = "actions.close",
        },
        columns = {
            "permissions",
            "size",
            "mtime",
            "icon",
        },
        constrain_cursor = "name",
        float = {
            padding = 4,
            max_width = 80,
            max_height = 25,
        },
        view_options = {
            show_hidden = true,
        },
    },
    keys = {
        {
            "-",
            function()
                require("oil").open()
            end,
            desc = "Open parent directory",
        },
    },
}

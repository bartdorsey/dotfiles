local function fuzzily_search()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(
        require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
        })
    )
end

local function open_file_browser()
    require("telescope").extensions.file_browser.file_browser()
end

return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = vim.fn.executable("make") == 1,
                config = function()
                    pcall(require("telescope").load_extension, "fzf")
                end,
            },
            {
                "nvim-telescope/telescope-ui-select.nvim",
            },
        },
        cmd = { "Telescope" },
        keys = {
            {
                "<leader>o",
                "<cmd>Telescope oldfiles cwd_only=true<cr>",
                desc = "Find recently opened files",
            },
            {
                "<leader><space>",
                "<cmd>Telescope buffers<cr>",
                desc = "Find existing buffers",
            },
            {
                "<leader>sf",
                "<cmd>Telescope find_files<cr>",
                desc = "Search Files",
            },
            {
                "<leader>/",
                fuzzily_search,
                desc = "[/] Fuzzily search in current buffer",
            },
            {
                "<leader>sh",
                "<cmd>Telescope help_tags<cr>",
                desc = "Search Help",
            },
            {
                "<leader>sw",
                "<cmd>Telescope grep_string<cr>",
                desc = "Search Current Word",
            },
            {
                "<leader>sr",
                "<cmd>Telescope live_grep<cr>",
                desc = "Search by Grep",
            },
            {
                "<leader>sd",
                "<cmd>Telescope diagnostics<cr>",
                desc = "Search Diagnostics",
            },
            {
                "<leader>cp",
                "<cmd>Telescope commands<cr>",
                desc = "Command Pallete",
            },
            {
                "<leader>gf",
                "<cmd>Telescope git_files<cr>",
                desc = "Search Git Files",
            },
            {
                "<leader>sk",
                "<cmd>Telescope keymaps<cr>",
                desc = "Search Keymaps",
            },
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = { "^.git/" },
                    mappings = {
                        i = {
                            ["<C-u>"] = false,
                            ["<C-d>"] = false,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                },
                extensions = {
                    glyph = {
                        action = function(glyph)
                            vim.api.nvim_put({ glyph.value }, "c", false, true)
                        end,
                    },
                    emoji = {
                        action = function(emoji)
                            vim.api.nvim_put({ emoji.value }, "c", false, true)
                        end,
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
    {
        "ghassan0/telescope-glyph.nvim",
        keys = {
            {
                "<leader>snf",
                "<cmd>Telescope glyph<cr>",
                desc = "Search Nerd Font Glyphs",
            },
        },
        config = function()
            pcall(require("telescope").load_extension, "glyph")
        end,
    },
    {
        "xiyaowong/telescope-emoji.nvim",
        keys = {
            { "<leader>se", "<cmd>Telescope emoji<cr>", desc = "Search Emoji" },
        },
        config = function()
            pcall(require("telescope").load_extension, "emoji")
        end,
    },
    {
        "sudormrfbin/cheatsheet.nvim",
        keys = {
            {
                "<leader>cht",
                "<cmd>Telescope cheatsheet<cr>",
                desc = "Cheatsheet",
            },
        },
        dependencies = { "nvim-lua/popup.nvim" },
        config = function()
            pcall(require("telescope").load_extension, "cheatsheet")
        end,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        keys = {
            { "<leader>fb", open_file_browser, desc = "File Browser" },
        },
        config = function()
            pcall(require("telescope").load_extension, "file_browser")
        end,
    },
    {
        "nvim-telescope/telescope-dap.nvim",
        keys = {},
        config = function() end,
    },
    {
        "nvim-telescope/telescope-media-files.nvim",
        keys = {
            {
                "<leader>sm",
                "<cmd>Telescope media_files<cr>",
                desc = "Find Media Files",
            },
        },
        config = function()
            require("telescope").load_extension("media_files")
        end,
    },
}

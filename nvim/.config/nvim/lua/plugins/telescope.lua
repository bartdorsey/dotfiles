local function fuzzily_search()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(
        require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
            flip_columns = nil,
        })
    )
end

local function open_file_browser()
    require("telescope").extensions.file_browser.file_browser()
end

-- local function open_command()
--     local in_wsl = os.getenv("WSL_DISTRO_NAME") ~= nil
--     if in_wsl then
--         return "wsl-open"
--     else
--         return "xdg-open"
--     end
-- end

return {
    {
        "nvim-telescope/telescope.nvim",
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
            {
                "cljoly/telescope-repo.nvim",
            },
        },
        cmd = { "Telescope" },
        keys = {
            {
                "<leader>fo",
                "<cmd>Telescope oldfiles cwd_only=true<cr>",
                desc = "Find recently opened files",
            },
            {
                "<leader><space>",
                "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
                desc = "Find existing buffers",
            },
            {
                "<leader>ff",
                "<cmd>Telescope find_files sort_mru=true sort_lastused=true<cr>",
                desc = "Search Files",
            },
            {
                "<leader>f/",
                fuzzily_search,
                desc = "[/] Fuzzily search in current buffer",
            },
            {
                "<leader>fh",
                "<cmd>Telescope help_tags<cr>",
                desc = "Search Help",
            },
            {
                "<leader>fw",
                "<cmd>Telescope grep_string<cr>",
                desc = "Search Current Word",
            },
            {
                "<leader>fr",
                "<cmd>Telescope live_grep<cr>",
                desc = "Search by Grep",
            },
            {
                "<leader>fd",
                "<cmd>Telescope diagnostics<cr>",
                desc = "Search Diagnostics",
            },
            {
                "<leader>:",
                "<cmd>Telescope commands<cr>",
                desc = "Command Pallete",
            },
            {
                "<leader>fg",
                "<cmd>Telescope git_files<cr>",
                desc = "Search Git Files",
            },
            {
                "<leader>fk",
                "<cmd>Telescope keymaps<cr>",
                desc = "Search Keymaps",
            },
            {
                "<leader>fc",
                "<cmd>Telescope colorscheme<cr>",
                desc = "Search Colorschemes",
            },
            {
                "<leader>fp",
                "<cmd>Telescope repo list<cr>",
                desc = "Find Git Repos",
            },
            {
                "<leader>fs",
                "<cmd>Telescope lsp_workspace_symbols<cr>",
                desc = "Find Symbols in Workspace",
            },
        },
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    layout_strategy = "flex",
                    color_devicons = true,
                    dynamic_preview_title = true,
                    border = true,
                    theme = "ivy",
                    sorting_strategy = "descending",
                    layout_config = {
                        flex = {
                            flip_columns = 120,
                        },
                        prompt_position = "bottom",
                        height = {
                            padding = 0,
                        },
                        width = {
                            padding = 0,
                        },
                        horizontal = {
                            preview_width = 0.5,
                            mirror = false,
                        },
                        vertical = {
                            preview_height = 0.75,
                            mirror = false,
                        },
                    },
                    file_ignore_patterns = {
                        "^.git/",
                        "^node_modules/",
                        "^.venv/",
                    },
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                            ["<C-u>"] = false,
                            ["<C-d>"] = false,
                        },
                    },
                },
                pickers = {
                    live_grep = {
                        grep_open_files = false,
                        additional_args = { "--hidden" },
                    },
                    find_files = {
                        hidden = true,
                    },
                    colorscheme = {
                        enable_preview = true,
                    },
                },
                extensions = {
                    repo = {
                        list = {
                            search_dirs = {
                                "~/github",
                                "~/gitlab",
                                "~/projects",
                            },
                        },
                    },
                },
            })
            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("messages")
            require("telescope").load_extension("repo")
            require("telescope").load_extension("bookmarks")
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
                "<leader>fm",
                "<cmd>Telescope media_files<cr>",
                desc = "Find Media Files",
            },
        },
        config = function()
            require("telescope").load_extension("media_files")
        end,
    },
}

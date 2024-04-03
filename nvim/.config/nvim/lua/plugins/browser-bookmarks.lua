return {
    "dhruvmanila/browser-bookmarks.nvim",
    version = "*",
    -- Only required to override the default options
    opts = {
        selected_browser = "buku",
        url_open_command = "wsl-open",
        -- Override default configuration values
        -- selected_browser = 'chrome'
    },
    dependencies = {
        "kkharji/sqlite.lua",
        "nvim-telescope/telescope.nvim",
    },
}

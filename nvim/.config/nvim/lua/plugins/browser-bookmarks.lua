return {
    "dhruvmanila/browser-bookmarks.nvim",
    version = "*",
    opts = {
        -- Override default configuration values
        selected_browser = "raindrop",
    },
    dependencies = {
        "kkharji/sqlite.lua",
        "nvim-telescope/telescope.nvim",
    },
}

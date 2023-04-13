return {
    "epwalsh/obsidian.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("obsidian").setup({
            dir = "~/Obsidian/Journal",
            daily_notes = {
                folder = "Daily Notes",
            },
            completion = {
                nvim_cmp = true,
            },
        })
    end,
}

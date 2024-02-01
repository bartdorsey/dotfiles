return {
    "code-biscuits/nvim-biscuits",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("nvim-biscuits").setup({
            default_config = {
                max_length = 2,
                trim_by_words = true,
                min_distance = 5,
                prefix_string = "↖️ ",
                cursor_line_only = true,
            },
        })
    end,
}

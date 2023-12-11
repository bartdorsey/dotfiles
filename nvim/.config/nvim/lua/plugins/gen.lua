return {
    "David-Kunz/gen.nvim",
    config = function()
        require("gen").setup({
            display_mode = "split",
            show_prompt = true,
            show_model = true,
            model = "codellama",
        })
    end,
}

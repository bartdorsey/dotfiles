return {
    "David-Kunz/gen.nvim",
    config = function()
        require("gen").setup({
            display_mode = "split",
            show_prompt = true,
            show_model = true,
            model = "llama3.2:1b",
            host = "nzxt.home",
            port = "11434",
            debug = true,
        })
    end,
}

return {
    "lukas-reineke/indent-blankline.nvim", -- Add indentation guides even on blank lines
    event = "BufReadPre",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
        indent = { char = "┊" },
        whitespace = {
            remove_blankline_trail = false,
        },
        scope = {
            enabled = false,
            show_exact_scope = false,
        },
    },
}

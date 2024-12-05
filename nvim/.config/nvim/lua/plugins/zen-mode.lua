return {
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    keys = { { "<c-w>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
    cmd = { "ZenMode" },
    config = true,
}

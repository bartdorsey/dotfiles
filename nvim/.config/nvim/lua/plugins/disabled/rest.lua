return {
    "rest-nvim/rest.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "vhyrro/luarocks.nvim",
            priority = 1000,
            config = true,
            opts = {
                rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
            },
        },
    },
    keys = {
        {
            "<leader>rr",
            "<Plug>RestNvim<cr>",
            desc = "Run REST command under cursor",
        },
    },
    ft = "http",
    config = function()
        require("rest-nvim").setup()
    end,
}

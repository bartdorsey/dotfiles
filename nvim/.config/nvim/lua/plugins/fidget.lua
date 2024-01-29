return {
    "j-hui/fidget.nvim",
    config = function()
        require("fidget").setup({
            notification = {
                override_vim_notify = true,
            },
        })
    end,
}

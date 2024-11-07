return {
    "j-hui/fidget.nvim",
    config = function()
        require("fidget").setup({
            progress = {
                ignore_empty_message = true,
                ignore_done_already = true,
                display = {
                    done_ttl = 1,
                    progress_icon = {
                        pattern = "meter",
                        period = 1,
                    },
                },
            },
            notification = {
                filter = vim.log.levels.INFO,
                override_vim_notify = true,
                view = {
                    group_separator = "",
                },
                window = {
                    winblend = 0,
                },
            },
        })
    end,
}

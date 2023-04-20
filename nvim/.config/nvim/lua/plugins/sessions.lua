return {
    "natecraddock/sessions.nvim",
    config = function()
        require("sessions").setup({
            session_filepath = ".nvim/session",
        })
    end,
}

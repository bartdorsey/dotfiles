return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            direction = "float",
            float_opts = {
                border = "curved",
            },
            open_mapping = [[<C-Space>]],
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
        })

        function _G.set_terminal_keymaps()
            local opts = { buffer = 0 }
            vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
            vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
        end

        vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

        local Terminal = require("toggleterm.terminal").Terminal
        local cargo_build = Terminal:new({
            cmd = "cargo watch -x build",
            hidden = true,
        })

        vim.keymap.set("n", "<leader>cb", function()
            cargo_build:toggle()
        end, { desc = "Cargo Build" })
    end,
}

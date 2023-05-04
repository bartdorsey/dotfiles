return {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "BufReadPre",
    config = function()
        require("toggleterm").setup({
            size = 80,
            direction = "vertical",
            open_mapping = [[<c-\>]],
            shade_terminals = false,
        })

        function _G.set_terminal_keymaps()
            local opts = { buffer = 0 }
            vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
            vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
            vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
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

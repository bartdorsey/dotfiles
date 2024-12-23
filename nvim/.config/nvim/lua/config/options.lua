-- Folding with nvim-treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldenable = true

-- Swap and undo
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.o.undofile = true

-- Neovide
if vim.g.neovide then
    vim.o.guifont = "Monaspace Argon"
    vim.g.neovide_refresh_rate = 170
    vim.g.neovide_refresh_rate_idle = 60
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_confirm_quit = false
    vim.g.neovide_floating_opacity = 1.0
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_cursor_animate_command_line = true
    vim.g.neovide_cursor_trail_size = 0.1
    vim.g.neovide_cursor_animation_length = 0.1
    vim.g.neovide_scroll_animation_length = 0.1
    vim.g.neovide_cursor_vfx_mode = "ripple"
    vim.cmd("cd ~")
end

-- Setup OSC52 for clipboard
vim.g.clipboard = {
    name = "OSC 52",
    copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
        ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
        ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
}

-- GuiCursor
vim.opt.guicursor = "n-v-c-sm:block-blinkon1,i-ci-ve:ver20,r-cr-o:hor20"

-- Configure vim short messages
vim.o.shortmess = "ltToOCIFa"

-- Diagnostic signs
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
        },
    },
    float = { border = "single" },
    virtual_text = {
        source = true,
    },
    virtual_lines = false,
})

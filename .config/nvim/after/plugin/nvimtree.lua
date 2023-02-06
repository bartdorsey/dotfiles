local nvim_tree = require("nvim-tree")

nvim_tree.setup({
  renderer = {
    highlight_opened_files = "all",
  },
  update_focused_file = {
    enable = true
  }
});

vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<cr>", { silent = true, noremap = true, desc = '[t]ree [t]oggle' })

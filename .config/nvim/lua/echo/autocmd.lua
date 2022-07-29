-- Start NERDTree and put the cursor back in the other window.
vim.api.nvim_create_autocmd({"VimEnter"}, { pattern = "*", command = "NERDTree | wincmd p"})
-- Exit Vim if NERDTree is the only window remaining in the only tab.
vim.api.nvim_create_autocmd({"BufEnter"}, { pattern = "*", command = "if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif"})

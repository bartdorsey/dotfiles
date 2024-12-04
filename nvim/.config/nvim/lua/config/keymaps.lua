-- Resizing windows
vim.keymap.set(
    "n",
    "<A-l>",
    "<cmd>vertical resize -4<CR>",
    { desc = "Make vertical split smaller" }
)
vim.keymap.set(
    "n",
    "<A-h>",
    "<cmd>vertical resize +4<CR>",
    { desc = "Make vertical split larger" }
)
vim.keymap.set(
    "n",
    "<A-k>",
    "<cmd>resize -2<CR>",
    { desc = "Make horizontal split smaller" }
)
vim.keymap.set(
    "n",
    "<A-j>",
    "<cmd>resize +2<CR>",
    { desc = "Make horizontal split larger" }
)

-- Let you move visual blocks with J and K
vim.keymap.set(
    "v",
    "J",
    ":m '>+1<cr>gv=gv",
    { desc = "Move selected lines up" }
) -- up
vim.keymap.set(
    "v",
    "K",
    ":m '<-2<cr>gv=gv",
    { desc = "move selected lines down" }
) -- down

-- Easier reach to beginning and end of lines
vim.keymap.set(
    "n",
    "H",
    "^",
    { desc = "Move to beginning of text on current line" }
)
vim.keymap.set("n", "L", "g_", { desc = "Move to end of text on current line" })
vim.keymap.set(
    "v",
    "L",
    "g_",
    { desc = "Move to end of text on current line - Visual mode" }
)
vim.keymap.set(
    "v",
    "H",
    "g_",
    { desc = "Move to end of text on current line - Visual mode" }
)

-- stay in visual mode when indenting
vim.keymap.set("v", "<", "<gv", { desc = "Unindent" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent" })

-- remap escape to a closer key
vim.keymap.set(
    "i",
    "jj",
    "<Esc>",
    { desc = "Remap escape to 'j' key twice for ergonomics - Insert mod" }
)

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Paste over without losing what's in your clipboard
vim.keymap.set("x", "<leader>P", '"_dP')

-- Yank into system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Captial Q is the worst place in the universe
vim.keymap.set("n", "Q", "<nop>")

-- q: is too close to :q for my tastes, and I never use it.
vim.keymap.set("n", "q:", "<nop>")

-- Control-S save
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>")

-- GuiCursor
vim.opt.guicursor = "n-v-c-sm:block-blinkon1,i-ci-ve:ver20,r-cr-o:hor20"

-- Configure vim short messages
vim.o.shortmess = "ltToOCIFa"

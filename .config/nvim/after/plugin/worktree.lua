require('git-worktree').setup()
require('telescope').load_extension("git_worktree")

vim.keymap.set("n", "<leader>wt", require('telescope').extensions.git_worktree.git_worktrees, { desc = "[G]it [W]orktrees" })
vim.keymap.set("n", "<leader>cwt", require('telescope').extensions.git_worktree.create_git_worktree, { desc = "[C]reate [W]ork[T]ree" })


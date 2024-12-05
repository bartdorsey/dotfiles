return {
    "mbbill/undotree",
    keys = {
        {
            "<leader>u",
            "<cmd>UndotreeToggle<cr>",
            desc = "[u]ndotree",
        },
    },
    init = function()
        vim.g.undotree_WindowLayout = 2
        vim.g.undotree_SplitWidth = 40
        vim.g.undotree_TreeNodeShape = "●"
        vim.g.undotree_TreeVertShape = "│"
        vim.g.undotree_TreeSplitShape = "╱"
        vim.g.undotree_TreeReturnShape = "╲"
        vim.g.undotree_DiffCommand = "diff -u"
    end,
    config = true,
}

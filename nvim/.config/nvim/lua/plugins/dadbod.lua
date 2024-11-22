return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        { "tpope/vim-dadbod", lazy = true },
        {
            "kristijanhusak/vim-dadbod-completion",
            ft = { "sql", "mysql", "plsql" },
            lazy = true,
        },
    },
    cmd = {
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
    },
    init = function()
        -- disable the need for dbext.vim
        vim.g.omni_sql_default_compl_type = "syntax"

        -- Your DBUI configuration
        vim.g.db_ui_use_nerd_fonts = 1
    end,
}

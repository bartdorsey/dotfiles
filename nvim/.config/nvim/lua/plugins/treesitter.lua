return {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    dependencies = {
        "j-hui/fidget.nvim",
        "windwp/nvim-ts-autotag",
    },
    event = { "BufRead", "BufNewFile" },
    config = function()
        -- [[ Configure Treesitter ]]
        -- See `:help nvim-treesitter`
        --

        require("nvim-treesitter.install").prefer_git = false
        require("nvim-treesitter.configs").setup({
            ensure_installed = {},
            modules = {},
            ignore_install = {},
            autotag = {
                enable = true,
            },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })

        local parser_config =
            require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.gotmpl = {
            install_info = {
                url = "https://github.com/ngalaiko/tree-sitter-go-template",
                files = { "src/parser.c" },
            },
            filetype = "gotmpl",
            used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl" },
        }

        -- Custom treesitter injections
        vim.api.nvim_create_autocmd("User", {
            pattern = "TSModuleInstalled",
            callback = function(args)
                if args.data == "python" then
                    vim.treesitter.query.set(
                        "python",
                        "injections",
                        [[ (call function:
                    (attribute
                        object: (identifier)
                        attribute: (identifier) @method
                            (#eq? @method "execute"))
                    arguments:
                    (argument_list
                        (string
                            (string_content) @injection.content
                                (#set! injection.language "sql"))))
                    ]]
                    )
                end
            end,
        })
    end,
}

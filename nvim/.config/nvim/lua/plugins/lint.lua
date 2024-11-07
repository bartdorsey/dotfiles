if os.getenv("DEVMODE") then
    return {
        "mfussenegger/nvim-lint",
        dependencies = {

            "j-hui/fidget.nvim",
        },
        config = function()
            local which = require("util").which

            local python_linters = {}
            local markdown_linters = {}

            if which("ruff") then
                table.insert(python_linters, "ruff")
                vim.notify("ruff enabled.")
            end

            if which("mypy") then
                table.insert(python_linters, "mypy")
                vim.notify("mypy enabled.")
            end

            if which("flake8") then
                table.insert(python_linters, "flake8")
                vim.notify("flake8 enabled.")
            end

            if which("cspell") then
                table.insert(markdown_linters, "cspell")
                vim.notify("cspell enabled.")
            end

            if which("markdownlint") or which("markdownlint-cli") then
                table.insert(markdown_linters, "markdownlint")
                vim.notify("markdownlint enabled.")
            end

            -- print out the linters
            require("lint").linters_by_ft = {
                python = python_linters,
                markdown = markdown_linters,
            }

            vim.api.nvim_create_autocmd(
                { "BufWritePost", "InsertLeave", "BufEnter" },
                {
                    callback = function()
                        require("lint").try_lint()
                    end,
                }
            )
        end,
    }
else
    return {}
end

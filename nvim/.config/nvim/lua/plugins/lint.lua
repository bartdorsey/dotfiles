if os.getenv("DEVMODE") then
    return {
        "mfussenegger/nvim-lint",
        config = function()
            local which = require("util").which

            local python_linters = {}

            if which("ruff") then
                table.insert(python_linters, "ruff")
            end

            if which("mypy") then
                table.insert(python_linters, "mypy")
            end

            if which("flake8") then
                table.insert(python_linters, "flake8")
            end
            -- print out the linters
            require("lint").linters_by_ft = {
                python = python_linters,
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

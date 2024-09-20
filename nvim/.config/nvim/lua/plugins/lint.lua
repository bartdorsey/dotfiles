return {
    "mfussenegger/nvim-lint",
    config = function()
        local which = require("util").which

        local python_linters = {}

        -- if which("ruff") then
        --     table.insert(python_linters, "ruff")
        -- end

        if which("flake8") then
            table.insert(python_linters, "flake8")
        end

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

        local lint_progress = function()
            local linters = require("lint").get_running()
            if #linters == 0 then
                return "󰦕"
            end
            return "󱉶 " .. table.concat(linters, ", ")
        end

        vim.api.nvim_create_user_command("LintInfo", lint_progress, {})
    end,
}

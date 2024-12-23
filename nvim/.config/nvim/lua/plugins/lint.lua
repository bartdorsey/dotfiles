return {
    "mfussenegger/nvim-lint",
    cond = os.getenv("DEVMODE") ~= nil,
    dependencies = {
        "linux-cultist/venv-selector.nvim",
        "j-hui/fidget.nvim",
    },
    config = function()
        local which = require("util").which

        local python_linters = {}
        local markdown_linters = {}

        if which("ruff") then
            table.insert(python_linters, "ruff")
        end

        if which("mypy") then
            table.insert(python_linters, "mypy")
        end

        if which("flake8") then
            table.insert(python_linters, "flake8")
        end

        if which("cspell") then
            table.insert(markdown_linters, "cspell")
        end

        if which("markdownlint") or which("markdownlint-cli") then
            table.insert(markdown_linters, "markdownlint")
        end

        if which("markdown-link-check") then
            vim.notify("Loading markdown-link-check")

            require("lint").linters.markdown_link_check = {
                name = "markdown_link_check",
                cmd = "markdown-link-check",
                stdin = false,
                append_fname = true,
                args = {
                    "--quiet",
                    "--config",
                    vim.fn.getcwd() .. "/.markdown-link-check.json",
                },
                stream = "stdout",
                ignore_exitcode = true,
                env = nil,
                parser = function(output, bufnr, linter_cwd)
                    local diagnostics = {}
                    vim.notify("Parsing markdown-link-check")
                    local lines = vim.split(output, "\n")
                    for _, value in ipairs(lines) do
                        local pieces = vim.split(value, " ")
                        if pieces[3] == "[✖]" then
                            local broken_link = pieces[4]

                            -- Search through the buffer for the broken link
                            local found = false
                            for line_num = 0, vim.api.nvim_buf_line_count(bufnr) - 1 do
                                local line = vim.api.nvim_buf_get_lines(
                                    bufnr,
                                    line_num,
                                    line_num + 1,
                                    false
                                )[1]
                                local col_start =
                                    string.find(line, vim.pesc(broken_link))

                                if col_start then
                                    -- Create diagnostic for the broken link
                                    table.insert(diagnostics, {
                                        bufnr = bufnr,
                                        lnum = line_num, -- Line number (0-based)
                                        col = col_start - 1, -- Column number (0-based)
                                        end_lnum = line_num,
                                        end_col = col_start + #broken_link - 1,
                                        severity = vim.diagnostic.severity.ERROR,
                                        source = "markdown-link-check",
                                        message = "Broken link: "
                                            .. broken_link,
                                    })
                                    found = true
                                    break
                                end
                            end

                            -- If the broken link was not found, log a warning
                            if not found then
                                vim.notify(
                                    "Broken link not found in buffer: "
                                        .. broken_link,
                                    vim.log.levels.WARN
                                )
                            end
                        end
                    end
                    return diagnostics
                end,
            }
            table.insert(markdown_linters, "markdown_link_check")
        end

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

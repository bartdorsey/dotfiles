return {
    "mfussenegger/nvim-lint",
    cond = os.getenv("DEVMODE") ~= nil,
    dependencies = {
        "linux-cultist/venv-selector.nvim",
        "j-hui/fidget.nvim",
    },
    ft = { "python", "markdown" },
    config = function()
        local which = require("util").which

        -- Delay linter detection until actually needed
        local function get_python_linters()
            local linters = {}
            if which("ruff") then
                table.insert(linters, "ruff")
            end
            if which("mypy") then
                table.insert(linters, "mypy")
            end
            -- if which("flake8") then
            --     table.insert(linters, "flake8")
            -- end
            return linters
        end

        local function get_markdown_linters()
            local linters = {}
            if which("cspell") then
                table.insert(linters, "cspell")
            end
            if which("markdownlint") or which("markdownlint-cli") then
                table.insert(linters, "markdownlint")
            end

            if which("markdown-link-check") then
                vim.notify("Loading markdown-link-check")

                -- Check if config file exists, otherwise use default args
                local config_file = vim.fn.getcwd()
                    .. "/.markdown-link-check.json"
                local args = { "--quiet" }
                if vim.fn.filereadable(config_file) == 1 then
                    table.insert(args, "--config")
                    table.insert(args, config_file)
                end

                require("lint").linters.markdown_link_check = {
                    name = "markdown_link_check",
                    cmd = "markdown-link-check",
                    stdin = false,
                    append_fname = true,
                    args = args,
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
                                            end_col = col_start
                                                + #broken_link
                                                - 1,
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
                table.insert(linters, "markdown_link_check")
            end
            return linters
        end

        -- Set up linters dynamically when files are opened
        local lint_module = require("lint")

        -- Initialize with empty tables to avoid the function error
        lint_module.linters_by_ft = {
            python = {},
            markdown = {},
        }

        -- Function to update linters based on current context
        local function update_linters()
            lint_module.linters_by_ft.python = get_python_linters()
            lint_module.linters_by_ft.markdown = get_markdown_linters()
        end

        vim.api.nvim_create_autocmd(
            { "BufWritePost", "InsertLeave", "BufEnter" },
            {
                callback = function()
                    update_linters()
                    lint_module.try_lint()
                end,
            }
        )

        -- Create a command to show linter status report
        vim.api.nvim_create_user_command("LintStatus", function()
            local which = require("util").which
            local lint = require("lint")

            -- Update linters to get current status
            update_linters()

            local report = {}
            table.insert(report, "=== NVIM-LINT STATUS REPORT ===")
            table.insert(report, "")

            -- Check DEVMODE status
            local devmode = os.getenv("DEVMODE")
            table.insert(
                report,
                "DEVMODE: "
                    .. (
                        devmode and "✓ Enabled"
                        or "✗ Disabled (plugin won't load)"
                    )
            )
            table.insert(report, "")

            -- Check configured linters by filetype
            table.insert(report, "Configured linters by filetype:")
            for ft, linters in pairs(lint.linters_by_ft) do
                local linter_count = #linters
                table.insert(
                    report,
                    string.format(
                        "  %s: %d linter%s",
                        ft,
                        linter_count,
                        linter_count == 1 and "" or "s"
                    )
                )
                for _, linter in ipairs(linters) do
                    table.insert(report, "    - " .. linter)
                end
            end
            table.insert(report, "")

            -- Check tool availability
            table.insert(report, "Tool availability:")
            local tools = {
                python = { "ruff", "mypy", "flake8" },
                markdown = {
                    "cspell",
                    "markdownlint",
                    "markdownlint-cli",
                    "markdown-link-check",
                },
            }

            for category, tool_list in pairs(tools) do
                table.insert(report, string.format("  %s tools:", category))
                for _, tool in ipairs(tool_list) do
                    local available = which(tool)
                    local status = available and "✓" or "✗"
                    table.insert(
                        report,
                        string.format("    %s %s", status, tool)
                    )
                end
                table.insert(report, "")
            end

            -- Check current buffer linters
            local current_ft = vim.bo.filetype
            if current_ft and current_ft ~= "" then
                table.insert(report, "Current buffer (" .. current_ft .. "):")
                local current_linters = lint.linters_by_ft[current_ft] or {}
                if #current_linters > 0 then
                    table.insert(report, "  Active linters:")
                    for _, linter in ipairs(current_linters) do
                        table.insert(report, "    - " .. linter)
                    end
                else
                    table.insert(
                        report,
                        "  No linters available (tools not installed)"
                    )
                end
                table.insert(report, "")
            end

            -- Check config files
            table.insert(report, "Configuration files:")
            local config_files = {
                { ".markdown-link-check.json", "markdown-link-check config" },
            }

            for _, config in ipairs(config_files) do
                local file, description = config[1], config[2]
                local path = vim.fn.getcwd() .. "/" .. file
                local exists = vim.fn.filereadable(path) == 1
                local status = exists and "✓" or "✗"
                table.insert(
                    report,
                    string.format("  %s %s (%s)", status, file, description)
                )
            end

            -- Display the report
            vim.cmd("new")
            vim.api.nvim_buf_set_lines(0, 0, -1, false, report)
            vim.bo.buftype = "nofile"
            vim.bo.bufhidden = "wipe"
            vim.bo.swapfile = false
            vim.bo.readonly = true
            vim.bo.modifiable = false
            vim.cmd("setlocal nomodified")
        end, { desc = "Show linter status report" })
    end,
}

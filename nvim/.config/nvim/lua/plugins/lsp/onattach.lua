return function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- Disable LSP Semantic Highlighting
    client.server_capabilities.semanticTokensProvider = nil

    vim.keymap.set(
        "n",
        "<leader>rn",
        vim.lsp.buf.rename,
        { desc = "Rename Symbol" }
    )
    vim.keymap.set(
        "n",
        "<leader>ca",
        vim.lsp.buf.code_action,
        { desc = "Code Action" }
    )
    vim.keymap.set(
        "n",
        "gl",
        vim.diagnostic.open_float,
        { desc = "Float Diagnostic" }
    )
    vim.keymap.set(
        "n",
        "gd",
        vim.lsp.buf.definition,
        { desc = "Goto Definition" }
    )
    vim.keymap.set(
        "n",
        "gr",
        require("telescope.builtin").lsp_references,
        { desc = "Goto References" }
    )
    vim.keymap.set(
        "n",
        "gI",
        vim.lsp.buf.implementation,
        { desc = "Goto Implementation" }
    )
    vim.keymap.set(
        "n",
        "<leader>D",
        vim.lsp.buf.type_definition,
        { desc = "Goto Type Definition" }
    )
    vim.keymap.set(
        "n",
        "<leader>ds",
        require("telescope.builtin").lsp_document_symbols,
        { desc = "Document Smbols" }
    )
    vim.keymap.set(
        "n",
        "<leader>ws",
        require("telescope.builtin").lsp_dynamic_workspace_symbols,
        { desc = "Workspace Symbols" }
    )
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
    vim.keymap.set(
        "n",
        "C-k",
        vim.lsp.buf.signature_help,
        { desc = "LSP Signaure Help" }
    )

    -- Lesser used LSP functionality
    vim.keymap.set(
        "n",
        "gD",
        vim.lsp.buf.declaration,
        { desc = "Goto Declaration" }
    )
    vim.keymap.set(
        "n",
        "<leader>wa",
        vim.lsp.buf.add_workspace_folder,
        { desc = "Workspace Add Folder" }
    )
    vim.keymap.set(
        "n",
        "<leader>wr",
        vim.lsp.buf.remove_workspace_folder,
        { desc = "Workspace Remove Folder" }
    )
    vim.keymap.set(
        "n",
        "gn",
        vim.diagnostic.goto_next,
        { desc = "Goto Next Diagnostic" }
    )
    vim.keymap.set(
        "n",
        "gp",
        vim.diagnostic.goto_prev,
        { desc = "Goto Previous Diagnostic" }
    )
    vim.keymap.set("n", "<leader>wl", function()
        require("notify")(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { desc = "Workspace List Folders" })

    local function organize_imports()
        local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
            title = "",
        }
        vim.lsp.buf.execute_command(params)
    end

    require("lsp_lines").setup()

    vim.keymap.set("", "<leader>dt", function()
        local config = vim.diagnostic.config()
        if config.virtual_text then
            vim.diagnostic.config({
                virtual_text = false,
                virtual_lines = true,
            })
        else
            vim.diagnostic.config({
                virtual_text = {
                    source = true,
                },
                virtual_lines = false,
            })
        end
    end, { desc = "Toggle Line Diagnostics" })

    local _border = "single"

    vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, {
            border = _border,
        })

    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = _border,
        })

    vim.diagnostic.config({
        float = { border = _border },
        virtual_text = {
            source = true,
        },
        virtual_lines = false,
    })
end

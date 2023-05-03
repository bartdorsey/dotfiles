return function(client, bufnr)
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

    vim.api.nvim_buf_create_user_command(
        bufnr,
        "OrganizeImports",
        organize_imports,
        { desc = "Organize TypeScript Imports" }
    )

    require("lsp_lines").setup()

    vim.keymap.set("", "<leader>dt", function()
        local config = vim.diagnostic.config()
        vim.diagnostic.config({
            virtual_text = not config.virtual_text,
            virtual_lines = not config.virtual_lines,
        })
    end, { desc = "Toggle Line Diagnostics" })

    vim.diagnostic.config({
        virtual_text = true,
        virtual_lines = false,
    })
end

-- Resizing windows
vim.keymap.set(
    "n",
    "<A-l>",
    "<cmd>vertical resize -4<CR>",
    { desc = "Make vertical split smaller" }
)
vim.keymap.set(
    "n",
    "<A-h>",
    "<cmd>vertical resize +4<CR>",
    { desc = "Make vertical split larger" }
)
vim.keymap.set(
    "n",
    "<A-k>",
    "<cmd>resize -2<CR>",
    { desc = "Make horizontal split smaller" }
)
vim.keymap.set(
    "n",
    "<A-j>",
    "<cmd>resize +2<CR>",
    { desc = "Make horizontal split larger" }
)

-- Move lines with Shift+Up/Down (works in both normal and visual mode)
vim.keymap.set("n", "<S-Down>", ":m .+1<cr>==", { desc = "Move line down" })
vim.keymap.set("n", "<S-Up>", ":m .-2<cr>==", { desc = "Move line up" })
vim.keymap.set("v", "<S-Down>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<S-Up>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Easier reach to beginning and end of lines
vim.keymap.set(
    "n",
    "H",
    "^",
    { desc = "Move to beginning of text on current line" }
)
vim.keymap.set("n", "L", "g_", { desc = "Move to end of text on current line" })
vim.keymap.set(
    "v",
    "L",
    "g_",
    { desc = "Move to end of text on current line - Visual mode" }
)
vim.keymap.set(
    "v",
    "H",
    "g_",
    { desc = "Move to end of text on current line - Visual mode" }
)

-- stay in visual mode when indenting
vim.keymap.set("v", "<", "<gv", { desc = "Unindent" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent" })

-- remap escape to a closer key
vim.keymap.set(
    "i",
    "jj",
    "<Esc>",
    { desc = "Remap escape to 'j' key twice for ergonomics - Insert mod" }
)

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", "<nop>")
vim.keymap.set("n", "<right>", "<nop>")
vim.keymap.set("n", "<up>", "<nop>")
vim.keymap.set("n", "<down>", "<nop>")

-- Paste over without losing what's in your clipboard
vim.keymap.set("x", "<leader>P", '"_dP')

-- Yank into system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Captial Q is the worst place in the universe
vim.keymap.set("n", "Q", "<nop>")

-- q: is too close to :q for my tastes, and I never use it.
vim.keymap.set("n", "q:", "<nop>")

-- Control-S save
-- vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>")

-- Find Sessions from MiniSessions
vim.keymap.set("", "<leader>ss", function()
    MiniSessions.select()
end, { desc = "Find Sessions" })

-- on LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function()
        vim.keymap.set("n", "<leader>i", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = "Toggle Inlay Hints" })
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
        vim.keymap.set("n", "gn", function()
            vim.diagnostic.jump({
                count = 1,
            })
        end, { desc = "Goto Next Diagnostic" })
        vim.keymap.set("n", "gp", function()
            vim.diagnostic.jump({
                count = -1,
            })
        end, { desc = "Goto Previous Diagnostic" })
        vim.keymap.set("n", "<leader>wl", function()
            require("notify")(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { desc = "Workspace List Folders" })

        vim.keymap.set("", "<leader>dt", function()
            local config = vim.diagnostic.config()
            if config == nil then
                return
            end
            if config.virtual_text then
                vim.diagnostic.config({
                    virtual_text = false,
                    virtual_lines = {
                        current_line = true,
                    },
                })
            else
                vim.diagnostic.config({
                    virtual_text = {
                        source = true,
                        current_line = true,
                    },
                    virtual_lines = false,
                })
            end
        end, { desc = "Toggle Line Diagnostics" })
    end,
})

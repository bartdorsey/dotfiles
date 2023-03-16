return {
    'VonHeikemen/lsp-zero.nvim',
    lazy = false,
    keys = {
        { '<leader>ff', '<cmd>LspZeroFormat<cr>', desc = '[f]ormat [f]ile' }
    },
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        { 'WhoIsSethDaniel/mason-tool-installer.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'windwp/nvim-autopairs' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },

        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
    },
    config = function()
        --  This function gets run when an LSP connects to a particular buffer.
        local on_attach = function(client, bufnr)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename Symbol' })
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })

            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Goto Definition' })
            vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = 'Goto References' })
            vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = 'Goto Implementation' })
            vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Goto Type Definition' })
            vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols,
                { desc = 'Document Smbols' })
            vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
                { desc = 'Workspace Symbols' })

            -- See `:help K` for why this keymap
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })

            -- Lesser used LSP functionality
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration' })
            vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'Workspace Add Folder' })
            vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
                { desc = 'Workspace Remove Folder' })
            vim.keymap.set('n', '<leader>wl', function()
                require('notify')(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, { desc = 'Workspace List Folders' })

            local function organize_imports()
                local params = {
                    command = "_typescript.organizeImports",
                    arguments = { vim.api.nvim_buf_get_name(0) },
                    title = ""
                }
                vim.lsp.buf.execute_command(params)
            end

            vim.api.nvim_buf_create_user_command(bufnr, 'OrganizeImports', organize_imports,
                { desc = "Organize TypeScript Imports" })
        end

        -- LSP settings.
        local lsp = require('lsp-zero')

        lsp.preset('minimal')

        lsp.set_preferences({
            suggest_lsp_servers = true,
            setup_servers_on_start = true,
            set_lsp_keymaps = true,
            configure_diagnostics = true,
            cmp_capabilities = true,
            manage_nvim_cmp = true,
            call_servers = 'local',
            sign_icons = {
                error = '✘',
                warn = '▲',
                hint = '⚑',
                info = ''
            }
        })

        lsp.ensure_installed({
            'tsserver',
            'eslint',
            'lua_ls',
            'rust_analyzer',
            'emmet_ls',
            'pyright',
            'marksman',
            'bashls',
            'jsonls'
        })

        -- Mason Tool Installer
        require('mason-tool-installer').setup({
            ensure_installed = {
                'prettierd',
                'alex',
                'cspell',
                'markdownlint'
            }
        })

        lsp.configure('emmet_ls', {
            settings = {
                filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' }
            }
        })

        require('nvim-autopairs').setup {}

        local cmp = require('cmp')
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ['<Tab>'] = cmp.mapping.confirm(),
            -- This makes Escape cancel the autocomplete AND go back to normal mode
            ['<Esc>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.abort()
                    vim.cmd("stopinsert")
                else
                    fallback()
                end
            end, { "i" })
        })

        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )

        lsp.setup_nvim_cmp({
            preselect = 'none',
            mapping = cmp_mappings,
            completion = {
                completeopt = 'menu,menuone,noinsert,noselect'
            },
        })

        lsp.on_attach(on_attach)
        lsp.nvim_workspace()
        lsp.setup()

        -- Make nvim runtime files discoverable to the server
        local runtime_path = vim.split(package.path, ';')
        table.insert(runtime_path, 'lua/?.lua')
        table.insert(runtime_path, 'lua/?/init.lua')

        vim.diagnostic.config({
            virtual_text = true
        });
    end
}

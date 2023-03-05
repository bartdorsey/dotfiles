return {
  'VonHeikemen/lsp-zero.nvim',
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },
    { 'windwp/nvim-autopairs' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },

    { 'j-hui/fidget.nvim' },
    -- Snippets
    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },
  },
  config = function()
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })

      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
      vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = '[G]oto [R]eferences' })
      vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = '[G]oto [I]mplementation' })
      vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Type [D]efinition' })
      vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols,
        { desc = '[D]ocument [S]ymbols' })
      vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
        { desc = '[W]orkspace [S]ymbols' })

      -- See `:help K` for why this keymap
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })

      -- Lesser used LSP functionality
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = '[W]orkspace [A]dd Folder' })
      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = '[W]orkspace [R]emove Folder' })
      vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, { desc = '[W]orkspace [L]ist Folders' })

      local function organize_imports()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = ""
        }
        vim.lsp.buf.execute_command(params)
      end

      local function format_file()
        if vim.lsp.buf.format then
          vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
          vim.lsp.buf.formatting()
        end
      end

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', format_file, { desc = 'Format current buffer with LSP' })

      vim.keymap.set('n', '<leader>ff', format_file, { desc = "[f]ormat [f]ile" })

      vim.api.nvim_buf_create_user_command(bufnr, 'OrganizeImports', organize_imports,
        { desc = "Organize TypeScript Imports" })
    end

    -- LSP settings.
    local lsp = require('lsp-zero')

    lsp.preset('recommended')

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
      'pyright'
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

    -- Turn on lsp status information
    require('fidget').setup()

    -- Make nvim runtime files discoverable to the server
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')

    vim.diagnostic.config({
      virtual_text = true
    });
  end
}

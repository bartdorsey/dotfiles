-- Theme
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('catppuccin')
      require("catppuccin").setup({
        integrations = {
          lsp_trouble = true,
          markdown = true,
          dap = {
            enabled = true,
            enable_ui = true
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            }
          },
          harpoon = true,
          neotree = true,
          gitsigns = true,
          ts_rainbow2 = true,
          which_key = true,
          notify = true,
          noice = true
        }
      })
    end,
  },
  {
    "feline-nvim/feline.nvim",
    dependencies = { "catppuccin/nvim" },
    config = function()
      require("feline").setup({
        components = require("catppuccin.groups.integrations.feline").get(),
      })
      require("feline").winbar.setup()
    end,
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et

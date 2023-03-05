function ColorMyPencils(color)
  color = color or "catppuccin"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Theme
return {
  -- StatusLine
  {
    'catppuccin/nvim',
    name = "catppuccin",
    config = function()
      ColorMyPencils()
      require('catppuccin').setup({
      })
    end
  },
  {
    'feline-nvim/feline.nvim',
    dependencies = { 'catppuccin/nvim' },
    config = function()
      require("feline").setup({
        components = require("catppuccin.groups.integrations.feline").get(),
      })
    end
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

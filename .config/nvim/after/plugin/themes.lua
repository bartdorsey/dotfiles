function ColorMyPencils(color)
  color = color or "catppuccin"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()

-- Setup catppuccin

require('catppuccin').setup({
})

require('feline').setup({
  components = require("catppuccin.groups.integrations.feline").get(),
})
require('feline').winbar.setup()

-- -- lualine
--
-- require('lualine').setup {
--   options = {
--     icons_enabled = true,
--     theme = 'catppuccin',
--     component_separators = { left = '', right = '' },
--     section_separators = { left = '', right = '' },
--   }
-- }
--
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

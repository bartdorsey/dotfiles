function ColorMyPencils(color)
  color = color or "tokyonight-night"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()

-- Setup tokyonight

require('tokyonight').setup({
  transparent = true,
  lualine_bold = true,
  styles = {
    comments = { italic = true },
  },
  dim_inactive = true,
})

-- lualine

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  }
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

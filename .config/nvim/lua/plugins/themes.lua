function ColorMyPencils(color)
  color = color or "catppuccin"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Theme
return {
  -- StatusLine
  { 'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          theme = "catppuccin"
        }
      })
    end },
  {
    'catppuccin/nvim',
    name = "catppuccin",
    config = function()
      ColorMyPencils()
      require('catppuccin').setup({})
    end
  }
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

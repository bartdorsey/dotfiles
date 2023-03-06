return {
  "folke/noice.nvim",
  config = function()
    require('noice').setup()
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify"
  }
}

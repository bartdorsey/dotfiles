return {
  cond = true,
  "echasnovski/mini.pairs",
  event = "BufReadPre",
  config = function(_, opts)
    require("mini.pairs").setup(opts)
  end,
}

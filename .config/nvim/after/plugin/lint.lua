
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.diagnostics.markdownlint,
  }
})


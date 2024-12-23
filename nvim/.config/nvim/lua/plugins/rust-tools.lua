return {
    -- Rust tools
    "simrat39/rust-tools.nvim",
    cond = os.getenv("DEVMODE") ~= nil,
    dependencies = {
        -- Autocompletion
        { "hrsh7th/cmp-nvim-lsp" },
    },
    config = function()
        local which = require("util").which
        -- Capabilities
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Rust Tools
        if which("rustc") then
            require("rust-tools").setup({
                capabilities = capabilities,
                tools = {
                    inlay_hints = {
                        only_current_line = true,
                    },
                },
            })
        end
    end,
}

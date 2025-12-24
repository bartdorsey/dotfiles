return {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    cond = os.getenv("DEVMODE") ~= nil,
    dependencies = {
        "rafamadriz/friendly-snippets",
        "fang2hou/blink-copilot",
        "folke/lazydev.nvim",
        "moyiz/blink-emoji.nvim",
        "MahanRahmati/blink-nerdfont.nvim",
        "ribru17/blink-cmp-spell",
    },
    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = { preset = "default" },
        cmdline = {
            completion = {
                menu = {
                    auto_show = true,
                },
            },
        },
        signature = {
            enabled = true,
            window = {
                border = "rounded",
            },
        },
        appearance = {
            nerd_font_variant = "mono",
        },
        completion = {
            documentation = {
                auto_show = true,
                window = {
                    border = "rounded",
                },
            },
            menu = {
                border = "rounded",
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind_icon", "kind", gap = 1 },
                    },
                },
            },
        },
        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = {
                "buffer",
                "cmdline",
                "omni",
                "copilot",
                "emoji",
                "lazydev",
                "lsp",
                "nerdfont",
                "path",
                "snippets",
                "spell",
            },
            providers = {
                copilot = {
                    name = "copilot",
                    module = "blink-copilot",
                    score_offset = -100,
                    async = true,
                },
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },
                emoji = {
                    module = "blink-emoji",
                    name = "Emoji",
                    score_offset = 0, -- Tune by preference
                    opts = { insert = true }, -- Insert emoji (default) or complete its name
                },
                nerdfont = {
                    module = "blink-nerdfont",
                    name = "Nerd Fonts",
                    score_offset = 1, -- Tune by preference
                    opts = { insert = true }, -- Insert nerdfont icon (default) or complete its name
                },
                spell = {
                    name = "Spell",
                    module = "blink-cmp-spell",
                    opts = { max_entries = 10 }, -- Max number of entries to show
                },
            },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}

local wezterm = require("wezterm")

local M = {}

function M.setup_tabline(config)
    local tabline = wezterm.plugin.require(
        "https://github.com/michaelbrusegard/tabline.wez"
    )

    tabline.setup({
        options = {
            icons_enabled = true,
            theme = "GruvboxDark",
            tabs_enabled = true,
            theme_overrides = {},
            section_separators = {
                left = wezterm.nerdfonts.pl_left_hard_divider,
                right = wezterm.nerdfonts.pl_right_hard_divider,
            },
            component_separators = {
                left = wezterm.nerdfonts.pl_left_soft_divider,
                right = wezterm.nerdfonts.pl_right_soft_divider,
            },
            tab_separators = {
                left = wezterm.nerdfonts.pl_left_hard_divider,
                right = wezterm.nerdfonts.pl_right_hard_divider,
            },
        },
        sections = {
            tabline_a = { "mode" },
            tabline_b = { "" },
            tabline_c = { "" },
            tab_active = {
                {
                    "index",
                    padding = 0,
                    fmt = function(string)
                        return string .. " "
                    end,
                },
                { "zoomed", padding = 0 },
                {
                    "process",
                    process_to_icon = {
                        ["lg"] = wezterm.nerdfonts.dev_git,
                        ["lazygit"] = wezterm.nerdfonts.dev_git,
                    },
                },
            },
            tab_inactive = {
                {
                    "index",
                    padding = 0,
                    fmt = function(string)
                        return string .. " "
                    end,
                },
                { "zoomed", padding = 0 },
                { "process" },
            },
            tabline_x = { "ram", "cpu" },
            tabline_y = { { "datetime", style = "%I:%M %p" } },
            tabline_z = { "hostname" },
        },
        extensions = {},
    })

    tabline.apply_to_config(config)
    config.use_fancy_tab_bar = false

    config.window_padding = {
        left = "2cell",
        right = "2cell",
        top = "1cell",
        bottom = "1cell",
    }
end

return M
